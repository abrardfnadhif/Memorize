//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 04/11/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    var theme: ThemeModel
    
    init(theme: ThemeModel) {
        self.theme = theme
        self.memoryGame = MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
        shuffle()
    }
    
    @Published private var memoryGame: MemoryGame<String>
    
    var cards: Array<Card> {
        return memoryGame.cards
    }
    
    var score: Int {
        memoryGame.score
    }
    
//    MARK: - intents
    func shuffle() {
        memoryGame.shuffle()
    }
    
    func choose(_ card: Card) {
        memoryGame.choose(card: card)
    }
}
