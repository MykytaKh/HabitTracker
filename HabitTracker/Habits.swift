//
//  Habits.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 24.10.2023.
//

import Foundation
import SwiftUI

class Habits: ObservableObject {
    
    @Published var items = [HabitItem]() {
        didSet {
            guard let data = try? JSONEncoder().encode(items) else { return }
            UserDefaults.standard.set(data, forKey: "habits")
        }
    }
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: "habits"),
              let items = try? JSONDecoder().decode([HabitItem].self, from: data) else {
            items = [HabitItem(name: "Name", description: "description", color: Color.Resolved.init(red: 1, green: 0, blue: 0), goal: 20, increment: 1, unit: "count", goalPeriod: .day, startDate: Date.now, endDate: nil)]
            return
        }
        self.items = items
    }
    
}
