//
//  RoundedTopRectangle.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import SwiftUI

struct RoundedTopRectangle: Shape {
    var radius: CGFloat = 34

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Top-left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)

        // Top-right corner
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(270),
                    endAngle: .degrees(0),
                    clockwise: false)

        // Right side down to bottom-right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))


        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

    
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    RoundedTopRectangle()
}
