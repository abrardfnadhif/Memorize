//
//  Cardify.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 06/11/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
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
    }
}
