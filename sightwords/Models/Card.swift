//
//  Card.swift
//  sightwords
//
//  Created by Chris Paine on 2/6/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import Foundation

struct Card  {
    let title: String
    var isSelected: Bool

    static var example: Card {
        return Card(title: "Where", isSelected: false)
    }
    
    static func load() -> [Card] {
        guard let url = Bundle.main.url(forResource: "Words", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let words = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String] else { return [] }
        return words.map { Card(title: $0, isSelected: true) }
    }
}
