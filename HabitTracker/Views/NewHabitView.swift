//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 12.10.2023.
//

import SwiftUI

struct NewHabitView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.self) private var environment
    
    @ObservedObject var habits: Habits
    
    @FocusState private var isTextfieldFocused: Bool
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var color: Color = .accentColor
    @State private var goal: Double = 1
    @State private var increment: Double = 1
    @State private var unit: String = "count"
    @State private var pickedGoalPeriod: GoalPeriod = .day
    @State private var startDate: Date? = Date.now
    @State private var endDate: Date?
    @State private var isShowingStartDatePicker: Bool = false
    @State private var isShowingEndDatePicker: Bool = false
    @State private var isShowingAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    List {
                        Section {
                            TextField("Habit name", text: $name)
                                .textFieldStyle(RegularTextFieldCustomStyle(color: color))
                                .focused($isTextfieldFocused)
                        } header: {
                            Text("Name")
                                .modifier(SectionTextHeaderCustomModifier())
                        }
                        .modifier(SectionCustomModifier())
                        
                        Section {
                            TextField("Habit description", text: $description)
                                .textFieldStyle(RegularTextFieldCustomStyle(color: color))
                                .focused($isTextfieldFocused)
                        } header: {
                            Text("Description")
                                .modifier(SectionTextHeaderCustomModifier())
                        }
                        .modifier(SectionCustomModifier())
                        
                        Section {
                            ColorPicker("Choose the color", selection: $color)
                                .labelsHidden()
                        } header: {
                            Text("Color")
                                .modifier(SectionTextHeaderCustomModifier())
                        }
                        .modifier(SectionCustomModifier())
                        
                        Section {
                            HStack {
                                TextField("Goal", value: $goal, format: .number)
                                    .textFieldStyle(NumericTextFieldCustomStyle(color: color))
                                    .focused($isTextfieldFocused)
                                
                                TextField("Unit", text: $unit)
                                    .textFieldStyle(SecondaryTextFieldCustomStyle(color: color))
                                    .focused($isTextfieldFocused)
                                
                                Text("/")
                                    .bold()
                                
                                Picker("Goal period", selection: $pickedGoalPeriod) {
                                    ForEach(GoalPeriod.allCases, id: \.self) {
                                        Text($0.rawValue)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(color.opacity(0.85))
                                )
                            }
                        } header: {
                            Text("Goal & Goal Period")
                                .modifier(SectionTextHeaderCustomModifier())
                        }
                        .modifier(SectionCustomModifier())
                        
                        Section {
                            HStack {
                                TextField("Increment", value: $increment, format: .number)
                                    .textFieldStyle(NumericTextFieldCustomStyle(color: color))
                                    .focused($isTextfieldFocused)
                                
                                TextField("Unit", text: $unit)
                                    .textFieldStyle(SecondaryTextFieldCustomStyle(color: color))
                                    .focused($isTextfieldFocused)
                            }
                        } header: {
                            Text("Increment")
                                .modifier(SectionTextHeaderCustomModifier())
                        }
                        .modifier(SectionCustomModifier())
                        
                        Section {
                            VStack(alignment: .center) {
                                HStack {
                                    Text("Start")
                                        .frame(width: 90, height: 10)
                                    
                                    Spacer()
                                    
                                    Text("End")
                                        .frame(width: 90, height: 10)
                                }
                                .foregroundColor(.secondary)
                                .font(.caption2)
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Button {
                                        isShowingStartDatePicker.toggle()
                                    } label: {
                                        Text(getString(from: startDate))
                                            .modifier(DateTextCustomModifier(color: color))
                                    }
                                    .buttonStyle(.borderless)
                                    
                                    Line()
                                        .stroke(.primary, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                                        .frame(maxWidth: geometry.size.width * 0.8)
                                    
                                    Button {
                                        isShowingEndDatePicker.toggle()
                                    } label: {
                                        Text(getString(from: endDate))
                                            .modifier(DateTextCustomModifier(color: color))
                                    }
                                    .buttonStyle(.borderless)
                                }
                            }
                        } header: {
                            Text("Habit Term")
                                .modifier(SectionTextHeaderCustomModifier())
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.insetGrouped)
                    .environment(\.defaultMinListRowHeight, 1)
                    .scrollContentBackground(.hidden)
                    
                    Button {
                        guard !name.isEmpty else { isShowingAlert.toggle(); return }
                        let habit = HabitItem(name: name, description: description, color: color.resolve(in: environment), goal: goal, increment: increment, unit: unit, goalPeriod: pickedGoalPeriod, startDate: startDate ?? Date.now, endDate: endDate)
                        habits.items.append(habit)
                        dismiss()
                    } label: {
                        Text("Complete")
                            .modifier(ButtonCustomModifier())
                            .frame(maxWidth: geometry.size.width * 0.82)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(color)
                    .padding(.bottom, 1)
                    .shadow(color: .black, radius: 2, x: 1, y: 1)
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("New habit")
                
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button {
                            isTextfieldFocused = false
                        } label: {
                            Text("Done")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                .sheet(isPresented: $isShowingStartDatePicker) {
                    DatePickerView($startDate, label: "Pick the start date", color: color)
                        .modifier(DateSheetCustomModifier())
                }
                .sheet(isPresented: $isShowingEndDatePicker) {
                    DatePickerView($endDate, label: "Pick the end date", color: color, startDate: startDate, isShowNoEndButton: true)
                        .modifier(DateSheetCustomModifier())
                }
                
                .alert("", isPresented: $isShowingAlert) {} message: {
                    Text("Please input a habit name")
                }
            }
        }
    }
    
    private func getString(from date: Date?) -> String {
        guard let date else { return "No End" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(habits: Habits())
    }
}
