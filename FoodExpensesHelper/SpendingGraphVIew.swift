//
//  SpendingGraphVIew.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI
import Charts
import SwiftData

//１日分のデータ
struct DailyExpense: Identifiable {
    var id = UUID()
    var day: String
    var amount: Int
}

struct SpendingGraphView: View {
    
    var remainingAmount: Int = 0 // 残りの金額を固定値として使用
    @Query private var spendings: [SpendingModel] // データを取得するためのQuery
    @State private var isLongPress = false
    
    var weeklyData: [DailyExpense] {
        let weekdays = ["月", "火", "水", "木", "金", "土", "日"]
        let calendar  = Calendar.current
        
        // 今日の日付を基準に週の始まりを計算
        let today = calendar.startOfDay(for: Date())
        let weekdayIndex = (calendar.component(.weekday, from: today) + 5) % 7 // 日曜日を0にするための調整
        let startOfWeek = calendar.date(byAdding: .day, value: -weekdayIndex, to: today)!
        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)! // 週の始まりから7日後まで
        
        let thisWeekSpends = spendings.filter { $0.date >= startOfWeek && $0.date < endOfWeek }
        
        var totalsByWeekday: [Int: Int] = [:]
        for spend in thisWeekSpends {
            let idx = (calendar.component(.weekday, from: spend.date) + 5) % 7 // 月=0 … 日=6
            totalsByWeekday[idx, default: 0] += spend.amount
        }
        return (0..<7).map {idx in
                DailyExpense(day: weekdays[idx], amount: totalsByWeekday[idx,default: 0])
        }
    }
    
    // 1日あたりの予算を計算
    private var dayilyBudget: Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let weekdayIndex = (calendar.component(.weekday, from: today) + 5) % 7
        let remainingDays = max(1, 7 - weekdayIndex)
        return Double(remainingAmount) / Double(remainingDays)
    }
    
    var body: some View {
        Chart(weeklyData) { data in
            BarMark(
                x: .value("Day", data.day),
                y: .value("Amount", data.amount),
                width: 20
            )
            .foregroundStyle(Color(#colorLiteral(red: 0, green: 0.667, blue: 0.663, alpha: 1)))
            .cornerRadius(6)
            .annotation(position: .top) {
                if isLongPress {
                    Text("\(data.amount)")
                        .font(.caption)
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.667, blue: 0.663, alpha: 1)))
                }
            }
            
            RuleMark(y: .value("Budget", dayilyBudget))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                .foregroundStyle(Color(#colorLiteral(red: 0, green: 0.667, blue: 0.663, alpha: 1)).opacity(0.5))
                .annotation(position: .leading) {
                    Text("\(Int(dayilyBudget))")
                        .font(.caption)
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.667, blue: 0.663, alpha: 1)))
                }
                
            
        }
        .frame(height: 200)
        .chartXAxis {
            AxisMarks(values: .automatic) { _ in
                AxisGridLine().foregroundStyle(.clear)
                AxisValueLabel().font(.system(size: 16))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .gesture(LongPressGesture().onEnded { _ in
            self.isLongPress.toggle()
        })
        .padding(.trailing,10)
        .padding(.leading,2)
    }
}

#Preview {
    let container = try! ModelContainer(
        for: SpendingModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let ctx = container.mainContext
    
    let base = Calendar.current.startOfDay(for: Date())
    _ = [700,800,900,1200,1400,1500,2300].enumerated().map { idx, val in
        let date = Calendar.current.date(byAdding: .day, value: -6+idx, to: base)!
        ctx.insert(SpendingModel(date: date, amount: val))
    }
    return SpendingGraphView(remainingAmount: 7000)
        .modelContainer(container)
}
