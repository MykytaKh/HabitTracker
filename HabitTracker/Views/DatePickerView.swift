//
//  DatePickerView.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 07.01.2024.
//

import SwiftUI

struct DatePickerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding private var bindingDate: Date?
    @State private var date: Date
    private let label: String
    private var isShowNoEndButton: Bool = false
    private let startDate: Date
    private let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    DatePicker(label, selection: $date, in: startDate..., displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    HStack {
                        if isShowNoEndButton {
                            Button(role: .destructive) {
                                bindingDate = nil
                                dismiss()
                            } label: {
                                Text("No End")
                                    .modifier(ButtonCustomModifier())
                                    .frame(maxWidth: geometry.size.width * 0.32)
                            }
                            .padding(.bottom, 27)
                            .buttonStyle(.borderedProminent)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                        }
                        
                        Button {
                            bindingDate = date
                            dismiss()
                        } label: {
                            Text("Confirm")
                                .modifier(ButtonCustomModifier())
                                .frame(maxWidth: geometry.size.width * (isShowNoEndButton ? 0.32 : 0.72))
                        }
                        .padding(.bottom, 27)
                        .buttonStyle(.borderedProminent)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                        .tint(color)
                    }
                }
                
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .bold()
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                .navigationTitle("Choose Date")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    init(_ bindingDate: Binding<Date?>, label: String, color: Color, startDate: Date? = nil, isShowNoEndButton: Bool = false) {
        self._bindingDate = bindingDate
        self.label = label
        self.color = color
        self.isShowNoEndButton = isShowNoEndButton
        self.startDate = startDate ?? Date.now
        guard let date = bindingDate.wrappedValue else {
            let date = Calendar.current.date(byAdding: .day, value: 1, to: self.startDate) ?? Date.now
            _date = State(initialValue: date)
            return
        }
        _date = State(initialValue: date)
    }
    
}
