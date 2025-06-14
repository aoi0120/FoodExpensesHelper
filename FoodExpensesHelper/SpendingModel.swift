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
    
    init(date: Date, amount: Int) {
        self.date = date
        self.amount = amount
    }
}

@Model
final class AppSettings {
    var budget: Int
    var expense: Int
    
    init(budget: Int, expense: Int) {
        self.budget = budget
        self.expense = expense
    }
}
