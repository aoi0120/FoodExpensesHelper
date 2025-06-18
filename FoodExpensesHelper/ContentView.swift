//
//  ContentView.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI
import SwiftData

// PickerTypeを外に出す
enum PickerType {
    case budget
    case expense
}

struct ContentView: View {
    @State private var isAlertPresented: Bool = false
    @State var path = NavigationPath()
    @State private var activePickerType: PickerType? = nil // どのピッカーか検出
    @Query var settings: [AppSettings] // data保存先
    @Query var spendings: [SpendingModel] // SpendingModelのデータを取得
    @Environment(\.modelContext) private var modelContext
    
    private func ensureSettingExists() {
        if settings.first == nil {
            let newSetting = AppSettings(budget: 3500, expense: 500)
            modelContext.insert(newSetting)
            try? modelContext.save()
        }
    }
    
    var totalSpend: Int {
        spendings.reduce(0) { $0 + $1.amount }
    }
    var remainingAmount: Int {
        (settings.first?.budget ?? 0) - totalSpend
    }
    var WeekOfMonth: Int {
        Calendar.current.component(.weekOfMonth, from: Date())
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            
            VStack(spacing: 0) {
                //Header
                ZStack {
                    Text("第\(WeekOfMonth)週目")
                        .font(.system(size: 20))
                        .padding(10)
                    
                    HStack {
                        Spacer()
                        
//                        Button(action: {
//                            path.append(0)
//                        }) {
//                            Image(systemName : "bell")
//                                .font(.system(size: 20))
//                                .padding(.horizontal, 30)
//                                .padding(.vertical, 10)
//                        }
                        Spacer()
                    }
                }
                .background(Color.white)
                
                //カード
                JudgmentCard(remainingAmount: remainingAmount)
                
                BottomCard(
                    onBudgetTapped: {
                        ensureSettingExists()
                        activePickerType = .budget
                        isAlertPresented = true
                    },
                    currentBudget: settings.first?.budget ?? 0, remainingAmount: remainingAmount
                )
                
                Spacer()
                
                Button(action: {
                    ensureSettingExists()
                    activePickerType = .expense
                    isAlertPresented = true
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.973, green: 0.71, blue: 0, alpha: 1)))
                        Text("支出を追加")
                            .font(.headline)
                            .foregroundColor(Color(#colorLiteral(red: 0.973, green: 0.71, blue: 0, alpha: 1)))
                    }
                    .padding(.bottom, 40)
                }
            }
            .background(Color(red: 0.949, green: 0.949, blue: 0.949))
            
            .overlay(
                ZStack {
                    if isAlertPresented,
                       let type = activePickerType,
                       let setting = settings.first {
                        
                        //background
                        Color.black.opacity(0.25)
                            .ignoresSafeArea()
                            .onTapGesture { isAlertPresented = false}
                        
                        PickerAlertView(
                            title: type == .budget ? "予算を選択" : "支出を選択",
                            values: type == .budget
                            ? Array(stride(from: 3500, through: 60000, by: 1000))
                            : Array(stride(from: 500, through: 6000, by: 500)),
                            selectedValue: Binding(
                                get: { type == .budget ? setting.budget : setting.expense},
                                set: { newValue in
                                    if type == .budget {
                                        setting.budget = newValue
                                    } else {
                                        setting.expense = newValue
                                    }
                                }
                            ),
                            onCancel: { isAlertPresented = false },
                            onOK: {
                                if type == .expense {
                                    // 支出の更新時に保存
                                    let newSpend = SpendingModel(date: Date(), amount: setting.expense)
                                    modelContext.insert(newSpend)
                                    try? modelContext.save()
                                }
                                isAlertPresented = false
                            }
                        )
                        .transition(.scale)
                    }
                }
                    .allowsHitTesting(isAlertPresented)
            )
            .onAppear {
                ensureSettingExists()
            }
            .navigationDestination(for: Int.self) { value in
                switch value {
                case 0:
                    NotificationView()
                default:
                    EmptyView()
                    
                }
                
            }
        }
    }
}
    
    
    
#Preview {
    let container: ModelContainer = {
        let container = try! ModelContainer(
            for: AppSettings.self, SpendingModel.self,
            configurations: .init(isStoredInMemoryOnly: true)
        )
        let ctx = container.mainContext
        let setting = AppSettings(budget: 3500, expense: 500)
        ctx.insert(setting)
        ctx.insert(SpendingModel(date: .now, amount: 700))
        return container
    }()
    
    ContentView()
        .modelContainer(container)
}
