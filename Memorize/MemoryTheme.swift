//
//  EmojiMemoryTheme.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 05/11/24.
//

import Foundation
import SwiftUI

struct MemoryTheme {
    private var themes: [Theme]
    private(set) var chosenTheme: Theme?
    
    init() {
        themes = []
        chosenTheme = nil
    }
    
    struct Theme {
        let name: String
        let emojis: [String]
        var numberOfPairs: Int
        let color: Color
    }
    
    mutating func createNewTheme(name: String, emojis: [String], numberOfPairs: Int, color: Color) -> Void {
        themes.append(Theme(name: name, emojis: emojis, numberOfPairs: numberOfPairs, color: color))
    }
    
    mutating func randomChooseTheme() -> Void {
        chosenTheme = themes.randomElement()
    }
}
