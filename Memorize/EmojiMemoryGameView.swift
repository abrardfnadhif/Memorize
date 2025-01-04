//
//  ContentView.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 02/11/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let deckWidth: CGFloat = 50
    private let dealInterval: TimeInterval = 0.15
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    
    var body: some View {
        VStack {
            Group {
                information
                cards
                    .opacity(viewModel.cards.count == 0 ? 0 : 1)
                    .foregroundColor(Color(rgba: viewModel.theme.color))
                
            }
            Spacer()
            footer
        }
        .padding()
    }
    
    private var footer: some View {
        HStack {
            Button(action: {
                withAnimation {
                    dealt.removeAll()
                    viewModel.shuffle()
                }
            }, label: {
                Text("New Game")
                    .font(.title)
                    .foregroundStyle(Color(rgba: viewModel.theme.color))
            })
            Spacer()
            deck
                .foregroundColor(Color(rgba: viewModel.theme.color))
        }
    }
    
    private var information: some View {
        VStack(alignment: .leading) {
            Text("Theme: \(viewModel.theme.name)")
            Text("Score: \(viewModel.score)")
            Text("Game Over")
                .opacity(viewModel.cards.count == 0 ? 1 : 0)
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            
            delay += dealInterval
        }
    }
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(
            width: deckWidth,
            height: deckWidth / aspectRatio
        )
        .onTapGesture {
            deal()
        }
        
    }
    
    @ViewBuilder
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.identity)
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation(.easeInOut(duration: 1)) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, card.id)
        }
    }
    
    @State private var lastScoreChange = (amount: 1, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: ThemeModel.builtins[0]))
}
