//
//  ContentView.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 02/11/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            Group {
                information
                cards
                    .animation(.default, value: viewModel.cards)
                
            }
            .opacity(viewModel.chosenTheme == nil ? 0 : 1)
            Spacer()
            Button(action: {
                viewModel.newGame()
                viewModel.shuffle()
            }, label: {
                Text("New Game")
                    .font(.title)
            })
        }
        .padding()
    }
    
    private var information: some View {
        VStack(alignment: .leading) {
            Text("Theme: \(viewModel.chosenTheme?.name ?? "")")
            Text("Score: \(viewModel.score)")
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
            Text(card.id)
        }
        .foregroundColor(viewModel.chosenTheme == nil ? .red : viewModel.chosenTheme!.color)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
             base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
