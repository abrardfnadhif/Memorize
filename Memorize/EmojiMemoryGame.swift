//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 04/11/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let vehicleEmojis: [String] = ["🚕", "🛴", "🏍️", "🚂", "✈️", "🚁", "⛵️", "🚢"]
    private static let animalEmojis: [String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁", "🐮", "🐷"]
    private static let foodEmojis: [String] = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🍅", "🍆"]
    
    private static func createMemoryTheme() -> MemoryTheme {
        var memoryTheme = MemoryTheme()
        memoryTheme.createNewTheme(name: "Vehicle", emojis: vehicleEmojis, numberOfPairs: vehicleEmojis.count, color: .orange)
        memoryTheme.createNewTheme(name: "Animal", emojis: animalEmojis, numberOfPairs: animalEmojis.count, color: .teal)
        memoryTheme.createNewTheme(name: "Food", emojis: foodEmojis, numberOfPairs: foodEmojis.count, color: .blue)
        
        return memoryTheme
    }
    
    private func createMemoryGame(numberOfPairs: Int, emojis: [String]) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var memoryTheme = createMemoryTheme()
    @Published private var memoryGame: MemoryGame<String>? = nil
    
    var chosenTheme: MemoryTheme.Theme? {
        return memoryTheme.chosenTheme
    }
    
    var cards: Array<Card> {
        if memoryGame == nil {
            return []
        } else {
            return memoryGame!.cards
        }
    }
    
    var score: Int {
        if memoryGame == nil {
            return 0
        } else {
            return memoryGame!.score
        }
    }
    
//    MARK: - intents
    func newGame() {
        memoryTheme.randomChooseTheme()
        if memoryTheme.chosenTheme != nil {
            memoryGame = createMemoryGame(numberOfPairs: memoryTheme.chosenTheme!.numberOfPairs, emojis: memoryTheme.chosenTheme!.emojis.shuffled())
        }
    }
    
    func shuffle() {
        if memoryGame != nil {
            memoryGame!.shuffle()
        }
    }
    
    func choose(_ card: Card) {
        if memoryGame != nil {
            memoryGame!.choose(card: card)
        }
    }
}
