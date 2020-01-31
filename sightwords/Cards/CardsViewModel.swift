//
//  CardsViewModel.swift
//  sightwords
//
//  Created by Chris Paine on 2/17/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

class CardsViewModel: ObservableObject {
    @Published var cards = [Card]()
        
    func resetCards() {
        if cards.isEmpty {
            loadCards()
        }
    }
    
    func loadCards() {
        if let cards = Card.load()?.shuffled() {
            self.cards = cards
        }
        //self.cards = [Card.example]
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }

    func sortCards() {
        cards.sort { $0.title.caseInsensitiveCompare($1.title) == .orderedAscending }
    }

    func addCard(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        guard trimmedTitle.isEmpty == false else { return }
        
        let card = Card(title: trimmedTitle)
        cards.insert(card, at: 0)
        saveData()
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func saveData() {
        
    }
}
