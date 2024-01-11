//
//  SectionTextHeaderCustomModifier.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 06.01.2024.
//

import SwiftUI

struct SectionTextHeaderCustomModifier: ViewModifier {
 
    func body(content: Content) -> some View {
        content
            .textCase(nil)
            .foregroundColor(.primary)
            .font(.caption2.bold())
            .padding(.leading, -5)
    }
    
}
