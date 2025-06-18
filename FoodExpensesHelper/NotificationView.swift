//
//  NotificationView.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/17.
//

import SwiftUI
import SwiftData

struct Remind: View {
    var name = "変更して"
    var body: some View {
        HStack(spacing: 0) {
            
            Text(name)
                .padding(.horizontal, 10)
            
            Spacer()
            
            Button(action: {
                // 昼のリマインドのアクション
                
            }) {
                HStack(spacing: 6) {
                    Text("12:00")
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
            .padding(.trailing, 10)
        }
    }
}

struct NotificationView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            //Header
            ZStack {
                Text("通知設定")
                    .font(.system(size: 20))
                    .padding(10)
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .padding(.horizontal, 20)
                        
                    }
                    Spacer()
                    
                }
            }
            .background(Color.white)
            
            Remind(name: "昼のリマインド")
                
                
                Spacer()
            }
            .background(Color(red: 0.949, green: 0.949, blue: 0.949))
            .toolbar(.hidden, for: .navigationBar)
    
        
    }
}

#Preview {
    NotificationView()
}
