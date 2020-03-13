//
//  CardsStack.swift
//  sightwords
//
//  Created by Chris Paine on 1/30/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct CardsStack: View {
    @EnvironmentObject var userData: UserData

    @State private var showSettingsScreen = false
            
    @State private var cards = [Card]()
    
    @State private var timeRemaining = 0
    
    @State private var lastRemoved: Card?
    
    private var feedback = UINotificationFeedbackGenerator()
                    
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button("Reload", action: {
                        self.loadCards()
                    }).padding()
                    
                    Spacer()
                    
                    if userData.timerSeconds > 0 {
                        TimerView(timeRemaining: $timeRemaining)
                    }
                    
                    Spacer()
                    
                    Button("Settings", action: {
                        self.showSettingsScreen.toggle()
                    }).padding()
                }
                
                Spacer()
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index], index: index + 1) {
                            self.removeCard(at: index)
                            self.resetTimer()
                        }
                        .stacked(at: index, in: self.cards.count)
                        .environmentObject(self.userData)
                    }
                }
                
                Spacer()
            }
            .padding(10)
        }
        .onTapGesture(count: userData.tapsToUndoCardRemoved, perform: undoRemove)
        .onAppear(perform: loadCards)
        .sheet(isPresented: $showSettingsScreen, onDismiss: {
            self.showSettingsScreen = false
            self.loadCards()
        }) {
            SettingsView(showSettingsScreen: self.$showSettingsScreen)
                .environmentObject(self.userData)
        }
    }
    
    func loadCards() {
        var cards = userData.cards.filter({ $0.isSelected })
        
        if cards.isEmpty {
            cards = userData.cards
        }
        
        self.cards = cards.shuffled()
        //self.cards = [Card.example]
        
        self.timeRemaining = userData.timerSeconds
    }
    
    func removeCard(at index: Int) {
        /// Temporarily store last removed card
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
    
    func resetTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timeRemaining = self.userData.timerSeconds
        }
    }
}

#if DEBUG
struct CardsStack_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardsStack()
            //CardsStack().previewLayout(.fixed(width: 568, height: 320))
        }
    }
}
#endif
