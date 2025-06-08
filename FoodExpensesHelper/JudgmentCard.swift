//
//  JudgmentCard.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI

struct JudgmentCard: View {
    var mode: Int = 0 //default 0
    let font: Array<String> = ["行ける！楽しんで！", "やめた方が良いかも","やばい！倒れちゃう"]
    let color: Array<Color> = [Color(#colorLiteral(red: 0.227, green: 0.369, blue: 0.647, alpha: 1)), Color(#colorLiteral(red: 0.847, green: 0.867, blue: 0.255, alpha: 1)), Color(#colorLiteral(red: 0.937, green: 0.639, blue: 0.282, alpha: 1))]
    let Photo: Array<String> = ["good", "warning", "caution"]
    
    func modeColor(mode: Int) -> Color {
        return color[mode]
    }
    
    func modeFont(mode: Int) -> String {
        return font[mode]
    }
    
    func modeImage(mode: Int) -> String {
        return  Photo[mode]
    }
    
    var body: some View {
        ZStack {
            Text(modeFont(mode: mode))
                .font(.system(size: 40))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: 220)
        .background(Color.white)
        .overlay(
            Image(Photo[mode])
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .padding(.horizontal, 40),
            alignment: .bottomTrailing
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .foregroundColor(Color(#colorLiteral(red: 0.227, green: 0.369, blue: 0.647, alpha: 1)))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 9)
                .fill(modeColor(mode: mode))
                .padding(1)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, y: 10)
        
        .padding(.horizontal, 15)
        .padding(.top, 25)
    }
}

#Preview {
    JudgmentCard()
}
