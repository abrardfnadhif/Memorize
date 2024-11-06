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
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            Group {
                information
                cards
                    .animation(.default, value: viewModel.cards)
                    .opacity(viewModel.cards.count == 0 ? 0 : 1)
                    .foregroundColor(viewModel.chosenTheme == nil ? .red : viewModel.chosenTheme!.color)
                
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
            Text("Game Over")
                .opacity(viewModel.cards.count == 0 && viewModel.chosenTheme != nil ? 1 : 0)
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
