//
//  bottomCard.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI

struct bottomCard: View {
    var body: some View {
        VStack{
            
            HStack {
                Text("今週の食費")
                    .font(.system(size: 20))
                    .padding(.horizontal, 5)
                Spacer()
            }
            .padding(10)
            HStack {
                Spacer()
                HStack {
                    Text("残り 15000円")
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
    bottomCard()
}
