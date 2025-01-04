//
//  ThemeModel.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 21/11/24.
//

import Foundation

struct ThemeModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var emojis: [String]
    var color: RGBA
    var numberOfPairs: Int
    
    static var builtins: [ThemeModel] {[
        ThemeModel(name: "Vehicle", emojis: ["🚕", "🛴", "🏍️", "🚂", "✈️", "🚁", "⛵️", "🚢"], color: RGBA(color: .orange), numberOfPairs: 4),
        ThemeModel(name: "Animal", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁", "🐮", "🐷"], color: RGBA(color: .teal), numberOfPairs: 12),
        ThemeModel(name: "Food", emojis: ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🍅", "🍆"], color: RGBA(color: .blue), numberOfPairs: 16)
    ]}
}
