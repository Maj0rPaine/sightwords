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
    
    @State var showEditScreen = false
    
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            
            //            VStack {
            //                HStack {
            //                    Spacer()
            //                    Button("Settings", action: {
            //                        self.showEditScreen.toggle()
            //                    })
            //                    .padding()
            //                }
            //
            //                Spacer()
            //            }
            
            VStack {
                if cardsViewModel.cards.isEmpty {
                    Button("Reload Cards", action: self.cardsViewModel.resetCards)
                } else {
                    ZStack {
                        ForEach(0..<cardsViewModel.cards.count, id: \.self) { index in
                            CardView(card: self.cardsViewModel.cards[index], index: index + 1) {
                                self.cardsViewModel.removeCard(at: index)
                            }
                            //.stacked(at: index, in: self.cards.count)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear(perform: cardsViewModel.resetCards)
        .sheet(isPresented: $showEditScreen, onDismiss: {
            self.showEditScreen = false
            self.cardsViewModel.resetCards()
        }) {
            EditCardsView(showEditScreen: self.$showEditScreen, cardsViewModel: self.cardsViewModel)
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * -10))
    }
}
