//
//  ContentView.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 12.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var habits: Habits = Habits()
    @State private var isPresentAddView: Bool = false
    @State private var selectedDate: Date = Date.now
    
    var body: some View {
        NavigationView {
            VStack {
                WeekSlider(currentDate: $selectedDate)
                
                List {
                    ForEach(habits.items.filter{ $0.isPresented(for: selectedDate) }) { habit in
                        habitSection(habit)
                    }
                    .onDelete(perform: removeRows)
                }
                .environment(\.defaultMinListRowHeight, 65)
                
                .toolbar {
                    ToolbarItem {
                        Button {
                            isPresentAddView.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.primary)
                        }
                    }
                }
                .sheet(isPresented: $isPresentAddView) {
                    NewHabitView(habits: habits)
                }
            }
            .navigationTitle(selectedDate.relativeFormat("MMMM d"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func habitSection(_ habit: HabitItem) -> some View {
        Section {
            HStack {
                if habit.description.isEmpty {
                    Text(habit.name)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(habit.name)
                        
                        Text(habit.description)
                            .font(.caption2)
                    }
                }
                
                Spacer()
                
                Text(habit.getResult(for: selectedDate))
            }
            .listRowBackground(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.primary, lineWidth: 3)
                    .background(
                        GeometryReader { geometry in
                            Color(habit.color)
                                .frame(width: geometry.size.width *
                                       CGFloat(habit.getColorValue(for: selectedDate)))
                                .alignmentGuide(.leading) { _ in
                                    -geometry.frame(in: .local).minX
                                }
                                .opacity(0.85)
                        }
                            .animation(.default, value: habit.getColorValue(for: selectedDate))
                            .shadow(color: Color(habit.color), radius: 10)
                    )
            )
        }
        .contentShape(Rectangle())
        .onTapGesture {
            incrementResult(for: habit)
        }
        .onLongPressGesture {
            reset(for: habit)
        }
    }
    
    private func removeRows(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
    
    private func incrementResult(for habit: HabitItem) {
        guard let index = habits.items.firstIndex(where: { $0.id == habit.id }) else { return }
        habits.items[index].results[selectedDate, default: 0] += habit.increment
    }
    
    private func reset(for habit: HabitItem) {
        guard let index = habits.items.firstIndex(where: { $0.id == habit.id }) else { return }
        habits.items[index].results[selectedDate] = nil
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
