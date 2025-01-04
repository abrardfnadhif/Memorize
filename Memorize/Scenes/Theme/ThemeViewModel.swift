//
//  ThemeViewModel.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 02/01/25.
//

import Foundation

class ThemeViewModel: ObservableObject {
    private let userDefaultsKey: String = "Memorize"
    
    var themes: [ThemeModel] {
        get {
            UserDefaults.standard.themes(forKey: userDefaultsKey)
        }
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
    
    init() {
        if themes.isEmpty {
            themes = ThemeModel.builtins
            if themes.isEmpty {
                themes = [ThemeModel(name: "Warning", emojis: ["⚠️"], color: RGBA(color: .red), numberOfPairs: 1)]
            }
        }
    }
    
    var cursorIndex: Int = 0
    
    func append(_ theme: ThemeModel) {
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            cursorIndex = index
        } else {
            themes.append(theme)
            cursorIndex = themes.count - 1
        }
    }
    
    func append(name: String, emojis: [String], color: RGBA, numberOfPairs: Int) {
        append(ThemeModel(name: name, emojis: emojis, color: color, numberOfPairs: numberOfPairs))
    }
}

extension UserDefaults {
    func themes(forKey: String) -> [ThemeModel] {
        if let jsonData = data(forKey: forKey),
           let decodedThemes = try? JSONDecoder().decode([ThemeModel].self, from: jsonData){
                return decodedThemes
        } else {
            return []
        }
    }
    
    func set(_ themes: [ThemeModel], forKey key: String) {
        let data = try? JSONEncoder().encode(themes)
        set(data, forKey: key)
    }
}
