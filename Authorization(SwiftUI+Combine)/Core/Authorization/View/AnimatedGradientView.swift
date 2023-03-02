//
//  AnimatedGradientView.swift
//  Authorization(SwiftUI+Combine)
//
//  Created by zedsbook on 01.03.2023.
//

import SwiftUI

struct AnimatedGradientView: View {
    
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 0, y: 2)
    
    private var colors = [Color]()
    
    init(colors: [Color]) {
        self.colors = colors
    }
    
    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: start,
            endPoint: end
        )
        .onAppear {
            withAnimation(
                .easeInOut(duration: 3)
                .repeatForever()) {
                    self.start = UnitPoint(x: 1, y: 1)
                    self.end = UnitPoint(x: 0, y: 1)
                }
        }
    }
}
