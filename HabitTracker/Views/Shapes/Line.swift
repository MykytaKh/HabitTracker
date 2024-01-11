//
//  Line.swift
//  HabitTracker
//
//  Created by Mykyta Khlamov on 06.01.2024.
//

import SwiftUI

struct Line: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
    
}
