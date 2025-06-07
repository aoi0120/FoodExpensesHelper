//
//  ContentView.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Image(systemName: "bell")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
            }
            .background(Color.white)
            
            //カード
            JudgmentCard(mode: 1)
        }
        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
    }
}

#Preview {
    ContentView()
}
