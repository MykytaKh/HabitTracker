//
//  ButtonCustomModifier.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 11.01.2024.
//

import SwiftUI

struct ButtonCustomModifier: ViewModifier {
     
    func body(content: Content) -> some View {
        content
            .bold()
            .foregroundStyle(.white)
            .shadow(color: .black, radius: 2, x: 1, y: 1)
    }
    
}
