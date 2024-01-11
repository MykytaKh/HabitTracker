//
//  SectionCustomModifier.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 06.01.2024.
//

import SwiftUI

struct SectionCustomModifier: ViewModifier {
 
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .frame(height: 15)
    }
    
}
