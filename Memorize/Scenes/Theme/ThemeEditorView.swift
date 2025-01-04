//
//  ThemeEditorView.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 02/01/25.
//

import SwiftUI

struct ThemeEditorView: View {
    @Binding var theme: ThemeModel
    @Binding var showCursorPalette: Bool
    
    @State var color: Color
    @State private var emojisToAdd: String = ""
    
    private let emojiFont = Font.system(size: 40)
    
    var body: some View {
        Form() {
            Section(content: {
                TextField("Name", text: $theme.name)
            }, header: {
                Text("Name")
            })
            Section(content: {
                ColorPicker("Theme Color", selection: $color)
                    .onChange(of: color) { _, newColor in
                        theme.color = RGBA(color: newColor)
                    }
            }, header: {
                Text("Color")
            })
            Section(content: {
                Button(action: {
                    theme.numberOfPairs -= 1
                }, label: {
                    Image(systemName: "minus")
                })
                .frame(maxWidth: .infinity, alignment: .center)
                
                Text("\(theme.numberOfPairs)")
                    .foregroundColor(.primary)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button(action: {
                    theme.numberOfPairs += 1
                }, label: {
                    Image(systemName: "plus")
                })
                .frame(maxWidth: .infinity, alignment: .center)
            }, header: {
                Text("Number of Pairs")
            })
            Section(content: {
                TextField("Add Emojis Here", text: $emojisToAdd)
                    .font(emojiFont)
                    .onChange(of: emojisToAdd) { _, emojisToAdd in
                        if !emojisToAdd.isEmpty {
                            for character in emojisToAdd {
                                if character.isEmoji && !theme.emojis.contains("\(character)") {
                                    theme.emojis.append("\(character)")
                                }
                            }
                        }
                    }
                VStack {
                    Text("Tap to Remove Emojis")
                        .font(.caption)
                        .foregroundColor(.gray)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                        ForEach(Array(theme.emojis.enumerated()), id: \.element) { index, emoji in
                            Text(emoji)
                                .onTapGesture {
                                    withAnimation {
                                        theme.emojis.remove(at: index)
                                        emojisToAdd.remove(emoji.first!)
                                    }
                                }
                        }
                    }
                }
                .font(emojiFont)
            }, header: {
                Text("Emojis")
            })
        }
        Button(action: {
            showCursorPalette = false
        }, label: {
            Text("Save")
        })
    }
}

//#Preview {
//    ThemeEditorView()
//}
