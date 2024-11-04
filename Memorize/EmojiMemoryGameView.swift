//
//  ContentView.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 02/11/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    enum Theme: String {
        case vehicle = "Vehicle"
        case animal = "Animal"
        case food = "Food"
    }
    
    let vehicleEmojis: [String] = ["🚕", "🛴", "🏍️", "🚂", "✈️", "🚁", "⛵️", "🚢"]
    let animalEmojis: [String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁", "🐮", "🐷"]
    let foodEmojis: [String] = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🍅", "🍆"]
    
    @State var chosenEmojis: [String]
    @State var chosenTheme: Theme
    
    init(viewModel: EmojiMemoryGame) {
        self.chosenEmojis = (vehicleEmojis + vehicleEmojis).shuffled()
        self.chosenTheme = Theme.vehicle
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            themeChangers
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
    
    var themeChangers: some View {
        HStack(spacing: 40) {
            vehicleTheme
            animalTheme
            foodTheme
        }
        .imageScale(.large)
        .font(.title)
    }
    
    func themeChanger(theme: Theme, emojis: [String], symbol: String) -> some View {
        let isChosen = chosenTheme == theme
        return Button(action: {
            chosenEmojis = (emojis + emojis).shuffled()
            chosenTheme = theme
        }, label: {
            VStack {
                Image(systemName: "\(symbol)\(isChosen ? ".fill" : "")")
                Text(theme.rawValue).font(.title2)
            }
        })
        .disabled(isChosen)
    }
    
    var vehicleTheme: some View {
        return themeChanger(theme: Theme.vehicle, emojis: vehicleEmojis, symbol: "car")
    }
    
    var animalTheme: some View {
        return themeChanger(theme: Theme.animal, emojis: animalEmojis, symbol: "pawprint")
    }
    
    var foodTheme: some View {
        return themeChanger(theme: Theme.food, emojis: foodEmojis, symbol: "carrot")
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
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
