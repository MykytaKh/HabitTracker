//
//  HabitItem.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 24.10.2023.
//

import SwiftUI

struct HabitItem: Identifiable, Codable {
    
    var id = UUID()
    let name: String
    let description: String
    let color: Color.Resolved
    let goal: Double
    let increment: Double
    let unit: String
    let goalPeriod: GoalPeriod
    let startDate: Date
    let endDate: Date?
    var results = [Date: Double]()
    
    func isPresented(for date: Date) -> Bool {
        (startDate < date || startDate.isSameDate(date)) && (endDate ?? date) >= date
    }
    
    func getResult(for date: Date) -> String {
        String("\(results[date, default: 0].formatted())/\(goal.formatted())")
    }
    
    func getColorValue(for date: Date) -> Double {
        guard let result = results[date] else { return 0 }
        return min(result / goal, goal / goal)
    }
    
}

enum GoalPeriod: String, CaseIterable, Codable {
    
    case day = "Day"
    case week = "Week"
    case month = "Month"
    
}
