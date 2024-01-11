//
//  Date+Extension.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 20.11.2023.
//

import Foundation

extension Date {
    
    /// Returns a Boolean value indicating whether the given date is today.
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /// Returns a Boolean value indicating whether the given date is the same as current.
    func isSameDate(_ date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    /// Returns a string representation of a specified date using the receiving date format.
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// Returns a relative string representation of a specified date using the receiving date format.
    func relativeFormat(_ format: String) -> String {
        let relativeDF = DateFormatter()
        relativeDF.doesRelativeDateFormatting = true
        relativeDF.dateStyle = .long
        
        let absoluteDF = DateFormatter()
        absoluteDF.dateStyle = .long
        
        let relativeString = relativeDF.string(from: self)
        
        guard relativeString != absoluteDF.string(from: self) else {
            absoluteDF.dateFormat = format
            return absoluteDF.string(from: self)
        }
        return relativeString
    }
    
    /// Fetching week based on given date
    func fetchWeek(_ date: Date = .now) -> [WeekDay] {
        var week = [WeekDay]()
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)

        (-6...0).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfDate) {
                week.append(.init(date: weekday))
            }
        }
        
        return week
    }
    
    /// Creating next week, based on the last current week's date
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextWeekStartDate = calendar.date(byAdding: .weekOfMonth, value: 1, to: startOfLastDate) else { return [] }
        
        return fetchWeek(nextWeekStartDate)
    }
    
    /// Creating previous week, based on the first current week's date
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else { return [] }
        
        return fetchWeek(previousDate)
    }
    
    struct WeekDay: Identifiable {
        var id = UUID()
        var date: Date
    }
    
}
