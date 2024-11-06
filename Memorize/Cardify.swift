//
//  Cardify.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 06/11/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue}
    }
    
    private struct Constant {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: Constant.cornerRadius)
            
            base.strokeBorder(lineWidth: Constant.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
             base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}
