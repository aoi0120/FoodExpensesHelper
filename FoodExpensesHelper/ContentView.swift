//
//  ContentView.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            //Header
            HStack {
                Spacer()
                Image(systemName: "bell")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
            }
            .background(Color.white)
            
            //カード
            JudgmentCard(mode: 0)
            
            bottomCard()
            
            Spacer()
            
//            Image(systemName: "pencil")
            HStack {
                Button("予算変更") { isShowAlert.toggle() }
                    .alert("Error", isPresented: $isShowAlert) {
                        
                    } message: {
                        Text("エラーが発生しました")
                    }
                Spacer()
                Button("支出") { isShowAlert.toggle() }
                    .alert("支出", isPresented: $isShowAlert) {
                        
                    } message: {
                        Text("エラーが発生しました")
                    }
            }
            .padding()
        }
        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
    }
}

#Preview {
    ContentView()
}
