//
//  DateSheetCustomModifier.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 07.01.2024.
//

import SwiftUI

struct DateSheetCustomModifier: ViewModifier {
     
    func body(content: Content) -> some View {
        content
            .presentationDetents([.height(320)])
            .presentationDragIndicator(.hidden)
    }
    
}
