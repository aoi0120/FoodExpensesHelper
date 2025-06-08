//
//  SpendingGraphVIew.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI
import Charts

//１日分のデータ
struct DailyExpense: Identifiable {
    var id = UUID()
    var day: String
    var amout: Int
}

struct SpendingGraphView: View {
    var spendingData: [Int] = [700, 800, 900, 1200, 1400, 1500, 2300]
    @State private var isLongPress = false
    
    var weeklyData: [DailyExpense] {
        let weekdays = ["月", "火", "水", "木", "金", "土", "日"]
        var paddedData = spendingData
        if paddedData.count < 7 {
            paddedData += Array(repeating: 0, count: 7 - paddedData.count)
        }
        return paddedData.enumerated().map { index, value in
            DailyExpense(day: weekdays[index % 7], amout: value)
        }
    }
    
    var body: some View {
        Chart(weeklyData) { data in
            BarMark(
                x: .value("Day", data.day),
                y: .value("Amount", data.amout),
                width: 20
            )
            .foregroundStyle(Color(#colorLiteral(red: 0, green: 0.667, blue: 0.663, alpha: 1)))
            .cornerRadius(6)
            
            .annotation(position: .top) {
                if isLongPress {
                    Text("\(data.amout)")
                        .font(.caption)
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.667, blue: 0.663, alpha: 1)))
                }
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
        }
        )
        .padding(.trailing,10)
        .padding(.leading,2)
        
    }
}

#Preview {
    SpendingGraphView()
}
