//
//  UserData.swift
//  sightwords
//
//  Created by Chris Paine on 2/17/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import Foundation

final class UserData: ObservableObject {
    @Published var cards = Card.load()
    
    @Published var showCardNumber = UserDefaults.standard.bool(forKey: UserDefaults.showCardNumber) {
        didSet {
            UserDefaults.standard.set(self.showCardNumber, forKey: UserDefaults.showCardNumber)
        }
    }
    
    @Published var undoLastCardRemove = UserDefaults.standard.bool(forKey: UserDefaults.undoLastCardRemove) {
        didSet {
            UserDefaults.standard.set(self.undoLastCardRemove, forKey: UserDefaults.undoLastCardRemove)
        }
    }
    
    @Published var tapsToUndoCardRemoved = UserDefaults.standard.integer(forKey: UserDefaults.tapsToUndoCardRemoved) {
        didSet {
            UserDefaults.standard.set(self.tapsToUndoCardRemoved, forKey: UserDefaults.tapsToUndoCardRemoved)
        }
    }
}

extension UserDefaults {
    static let showCardNumber = "ShowCardNumber"
    static let undoLastCardRemove = "UndoLastCardRemove"
    static let tapsToUndoCardRemoved = "TapsToUndoCardRemoved"
    
    func registerDefaults() {
        guard let url = Bundle.main.url(forResource: "DefaultPreferences", withExtension: "plist"),
            let dictionary = NSDictionary(contentsOf: url) as? Dictionary<String, AnyObject> else { return }
        self.register(defaults: dictionary)
    }
}
