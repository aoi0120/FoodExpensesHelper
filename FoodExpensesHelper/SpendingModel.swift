//
//  SpendingModel.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import Foundation
import SwiftData

@Model
class SpendingModel {
    @Attribute var date: Date
    @Attribute var amount: Int
    
    init(date: Date, amout: Int) {
        self.date = date
        self.amount = amout
    }
}
