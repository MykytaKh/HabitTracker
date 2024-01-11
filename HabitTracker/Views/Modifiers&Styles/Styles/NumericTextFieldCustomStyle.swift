//
//  NumericTextFieldCustomStyle.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 07.01.2024.
//

import SwiftUI

struct NumericTextFieldCustomStyle: TextFieldStyle {
    
    var color: Color
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(RegularTextFieldCustomStyle(color: color))
            .multilineTextAlignment(.center)
            .frame(width: 40)
            .keyboardType(.decimalPad)
    }
    
}

