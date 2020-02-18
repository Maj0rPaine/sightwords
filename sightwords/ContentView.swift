//
//  ContentView.swift
//  sightwords
//
//  Created by Chris Paine on 1/30/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct ContentView: View {    
    @ObservedObject var cardsViewModel = CardsViewModel()
    
    @State var showSettingsScreen = false
    
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button("Settings", action: {
                        self.showSettingsScreen.toggle()
                    })
                    .padding()
                }
                
                Spacer()
            }
            
            VStack {
                if cardsViewModel.cards.isEmpty {
                    Button("Reload Cards", action: self.cardsViewModel.resetCards)
                } else {
                    ZStack {
                        ForEach(0..<cardsViewModel.cards.count, id: \.self) { index in
                            CardView(card: self.cardsViewModel.cards[index], index: index + 1) {
                                self.cardsViewModel.removeCard(at: index)
                            }
                            .stacked(at: index, in: self.cardsViewModel.cards.count)
                            .environmentObject(self.cardsViewModel.settings)
                        }
                    }
                }
            }
            .padding()
        }
        .onTapGesture(count: cardsViewModel.settings.tapsToUndoCardRemoved, perform: cardsViewModel.undoRemove)
        .onAppear(perform: cardsViewModel.resetCards)
        .sheet(isPresented: $showSettingsScreen, onDismiss: {
            self.showSettingsScreen = false
            self.cardsViewModel.resetCards()
        }) {
            SettingsView(showSettingsScreen: self.$showSettingsScreen)
                .environmentObject(self.cardsViewModel.settings)
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int, maxOffset: CGFloat = 3) -> some View {
        let offset = CGFloat(total - position)
        
        guard offset <= maxOffset else {
            return self.offset(CGSize(width: 0, height: maxOffset * -10))
        }
        
        return self.offset(CGSize(width: 0, height: offset * -10))
    }
}
