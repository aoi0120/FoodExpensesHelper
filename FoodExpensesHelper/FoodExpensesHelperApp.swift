//
//  FoodExpensesHelperApp.swift
//  FoodExpensesHelper
//
//  Created by AoiKobayashi on 2025/06/08.
//

import SwiftUI
import SwiftData

@main
struct FoodExpensesHelperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [SpendingModel.self])
    }
}
