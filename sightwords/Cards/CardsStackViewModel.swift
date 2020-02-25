//
//  CardsViewModel.swift
//  sightwords
//
//  Created by Chris Paine on 2/17/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

class CardsStackViewModel: ObservableObject {
    @Published var cards = [Card]()
    
    var userData = UserData()
    
    private var feedback = UINotificationFeedbackGenerator()
    
    /// Temporarily store last removed card
    var lastRemoved: Card?
        
    private func loadCards() {
        if let cards = userData.cards?.shuffled() {
            self.cards = cards
        }
        //self.cards = [Card.example]
    }
    
    func resetCards() {
        // TODO: Reset state
        
        if cards.isEmpty {
            loadCards()
        }
    }
    
    func reloadCards() {
        loadCards()
    }
    
    func removeCard(at index: Int) {
        lastRemoved = cards[index]
        cards.remove(at: index)
    }
    
    func undoRemove() {
        guard let card = lastRemoved, userData.undoLastCardRemove else {
            notifyFeedback(.warning)
            return
        }
        cards.append(card)
        lastRemoved = nil
    }
    
    func notifyFeedback(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        self.feedback.notificationOccurred(feedbackType)
    }
}
