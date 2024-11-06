//
//  CardView.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 06/11/24.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constant {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
    
    var body: some View {
        Pie(endAngle: .degrees(90))
            .opacity(Constant.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constant.FontSize.largest))
                    .minimumScaleFactor(Constant.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constant.Pie.inset)
            )
            .padding(Constant.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

#Preview {
    typealias Card = CardView.Card
    return HStack {
        CardView(Card(id: "test1", isFaceUp: true, content: "X"))
        CardView(Card(id: "test1", content: "X"))
    }
        .padding()
        .foregroundColor(.green)
}
