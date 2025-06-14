//
//  bottomCard.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI

//予算変更ボタン
struct BudgetPopupButton: View {
    var value: Int
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Text("\(value)")
                    .font(.headline)
                VStack(spacing: 1) {
                    Image(systemName: "chevron.up")
                        .font(.system(size: 10, weight: .semibold))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10, weight: .semibold))
                }
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4))
            )
        }
    }
}

struct BottomCard: View {

    
    var onBudgetTapped: () -> Void
//    var currentBudget: Int
    var currentBudget: Int // 予算を受け取る
    var remainingAmount: Int // 残りの金額を固定値として使用
    
    var body: some View {
        VStack{
            
            HStack {
                Text("今週の食費")
                    .font(.system(size: 20))
                    .padding(.horizontal, 5)
                Spacer()
                
                BudgetPopupButton(value: currentBudget, action: onBudgetTapped)
            }
            .padding(10)
            HStack {
                Spacer()
                HStack {
                    Text("残り \(remainingAmount)円")
                        .font(.system(size: 36, weight: .bold))
                        .padding(.trailing, 15)
                }
               
                
                }
            SpendingGraphView()
                .padding(.bottom, 10)
        
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.3), radius: 20, y: 30)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    .linearGradient(
                        colors: [.black.opacity(0.1), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color:.black.opacity(0.3), radius: 20, y: 20)
        
        .padding(.horizontal, 15)
        .padding(.top, 25)
        
        Spacer()
    }
    }

#Preview { 
    BottomCard(onBudgetTapped: {}, currentBudget: 20000,remainingAmount: 15000)
}
