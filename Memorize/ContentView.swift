//
//  ContentView.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 02/11/24.
//

import SwiftUI

struct ContentView: View {
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
    
    init() {
        self.chosenEmojis = (vehicleEmojis + vehicleEmojis).shuffled()
        self.chosenTheme = Theme.vehicle
    }
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChangers
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(chosenEmojis.indices, id: \.self) { index in
                CardView(content: chosenEmojis[index], theme: chosenTheme)
                    .aspectRatio(1, contentMode: .fit)
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
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
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
    let content: String
    var theme: ContentView.Theme
    @State var isFaceUp = false
    
    var body: some View {
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        .onChange(of: theme) {
            isFaceUp = false
        }
    }
}

#Preview {
    ContentView()
}
