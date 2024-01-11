//
//  WeekSlider.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 20.11.2023.
//

import SwiftUI

struct WeekSlider: View {
    
    @Binding var currentDate: Date
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    
    var body: some View {
        TabView(selection: $currentWeekIndex) {
            ForEach(weekSlider.indices, id: \.self) { index in
                let week = weekSlider[index]
                WeekView(week)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 110)
        .onAppear {
            if weekSlider.isEmpty {
                let currentWeek = currentDate.fetchWeek()
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
        .onChange(of: currentWeekIndex) { newValue in
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                paginateWeek()
            }
            currentDate = weekSlider[currentWeekIndex].last!.date
        }
    }
    
    @ViewBuilder
    private func WeekView(_ week: [Date.WeekDay]) -> some View {
        LazyHStack(spacing: 18) {
            
            ForEach(week) { day in
                
                VStack(spacing: 10) {
                    Text(day.date.format("eeeeee"))
                        .opacity(day.date.isSameDate(currentDate) ? 1 : 0.5)
                    
                    Text(day.date.format("dd"))
                        .opacity(0.5)
                        .padding(5)
                        .background(
                            Circle()
                                .stroke(day.date.isToday ? .blue : .pink, lineWidth: 2)
                                .opacity(0.4)
                        )
                }
                .frame(maxWidth: 45, maxHeight: 90)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.pink.opacity(day.date.isSameDate(currentDate) ? 0.3 : 0))
                )
                .onTapGesture {
                    withAnimation(.linear) {
                        currentDate = day.date
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func paginateWeek() {
        guard weekSlider.indices.contains(currentWeekIndex) else { return }
        if let firstDate = weekSlider[currentWeekIndex].first?.date,
           currentWeekIndex == 0 {
            weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
            weekSlider.removeLast()
            currentWeekIndex = 1
        } else if let lastDate = weekSlider[currentWeekIndex].last?.date,
                  currentWeekIndex == (weekSlider.count - 1) {
            weekSlider.append(lastDate.createNextWeek())
            weekSlider.removeFirst()
            currentWeekIndex = weekSlider.count - 2
        }
    }
    
}

struct WeekSlider_Previews: PreviewProvider {
    static var previews: some View {
        WeekSlider(currentDate: .constant(Date.now))
    }
}
