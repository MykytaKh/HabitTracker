//
//  TextFieldCustomStyle.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 06.01.2024.
//

import SwiftUI

struct RegularTextFieldCustomStyle: TextFieldStyle {
    
    var color: Color
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.caption2)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .foregroundColor(Color("TextFieldBackgroundColor"))
            )
            .padding(.leading, -10)
            .tint(color)
    }
    
}
