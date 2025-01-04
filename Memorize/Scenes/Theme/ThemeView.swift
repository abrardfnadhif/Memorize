//
//  ThemeView.swift
//  Memorize
//
//  Created by Abrar Dwi Fairuz Nadhif on 21/11/24.
//

import SwiftUI

struct ThemeView: View {
    @EnvironmentObject var store: ThemeViewModel
    
    @State private var showCursorPalette = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(store.themes.enumerated()), id: \.element.id) { index, theme in
                    ThemeNavigationLink(theme: theme)
                        .swipeActions(edge: .leading) {
                            Button(action: {
                                store.cursorIndex = index
                                showCursorPalette = true
                            }, label: {
                                Label("Info", systemImage: "info.circle")
                            })
                            .tint(.blue)
                        }
                }
                .onDelete { indexSet in
                    withAnimation {
                        store.themes.remove(atOffsets: indexSet)
                    }
                }
                .onMove { indexSet, newOffset in
                    withAnimation {
                        store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                    }
                }
            }
            .navigationDestination(for: ThemeModel.self) { theme in
                EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
            }
            .navigationTitle("Memorize")
            .toolbar {
                Button(action: {
                    store.append(name: "", emojis: [], color: RGBA(color: .black), numberOfPairs: 0)
                    showCursorPalette = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $showCursorPalette, content: {
            ThemeEditorView(
                theme: $store.themes[store.cursorIndex],
                showCursorPalette: $showCursorPalette,
                color: Color(rgba: store.themes[store.cursorIndex].color)
            )
        })
    }
    
    struct ThemeNavigationLink: View {
        let theme: ThemeModel
        
        var body: some View {
            NavigationLink(value: theme) {
                VStack(alignment: .leading) {
                    Text(theme.name)
                    Text("\(theme.numberOfPairs >= theme.emojis.count ? "All" : "\(theme.numberOfPairs)") of:")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(theme.emojis, id: \.self) { emoji in
                                Text(emoji)
                            }
                        }
                    }
                }
                .foregroundStyle(Color(rgba: theme.color))
            }
        }
    }
}

#Preview {
    ThemeView()
}
