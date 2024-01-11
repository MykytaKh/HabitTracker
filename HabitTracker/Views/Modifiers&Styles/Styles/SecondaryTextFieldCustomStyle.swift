//
//  SecondaryTextFieldCustomStyle.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 07.01.2024.
//

import SwiftUI

struct SecondaryTextFieldCustomStyle: TextFieldStyle {
    
    var color: Color
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.caption2)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .foregroundColor(Color("TextFieldBackgroundColor"))
            )
            .multilineTextAlignment(.center)
            .frame(width: 90)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .tint(color)
    }
    
}
