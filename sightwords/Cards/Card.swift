//
//  Card.swift
//  sightwords
//
//  Created by Chris Paine on 2/6/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import Foundation

struct Card {
    let title: String

    static var example: Card {
        return Card(title: "Label")
    }
    
    static func load() -> [Card]? {
        guard let settingsURL = Bundle.main.path(forResource: "Words", ofType: "plist"),
        let data = try? Data(contentsOf: URL(fileURLWithPath: settingsURL)),
        let words = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String] else { return nil }
        return words.map { Card(title: $0) }
    }
}