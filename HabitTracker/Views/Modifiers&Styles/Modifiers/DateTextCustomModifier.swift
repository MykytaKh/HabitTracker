//
//  DateTextCustomModifier.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 07.01.2024.
//

import SwiftUI

struct DateTextCustomModifier: ViewModifier {
 
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .modifier(ButtonCustomModifier())
            .font(.caption2)
            .frame(width: 90, height: 10)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .foregroundColor(color)
                    .shadow(color: .black, radius: 2, x: 1, y: 1)
            )
    }
    
}
