//
//  EditCardsView.swift
//  sightwords
//
//  Created by Chris Paine on 2/6/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct EditCardsView: View {
    @State private var newTitle = ""
    
    @Binding var showEditScreen: Bool
    
    @ObservedObject var cardsViewModel: CardsViewModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new card")) {
                    TextField("Title", text: $newTitle)
                    Button("Add card") {
                        self.cardsViewModel.addCard(title: self.newTitle)
                    }
                }

                Section {
                    ForEach(0..<cardsViewModel.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(self.cardsViewModel.cards[index].title)
                                .font(.headline)
                        }
                    }
                    .onDelete(perform: cardsViewModel.removeCards)
                }
            }
            .navigationBarTitle("Edit Cards")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
            .onAppear(perform: cardsViewModel.sortCards)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        self.showEditScreen = false
    }
}
