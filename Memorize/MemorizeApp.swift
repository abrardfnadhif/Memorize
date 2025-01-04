//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 02/11/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = ThemeViewModel()
    
    var body: some Scene {
        WindowGroup {
//            EmojiMemoryGameView(viewModel: game)
            ThemeView()
                .environmentObject(themeStore)
        }
    }
}
