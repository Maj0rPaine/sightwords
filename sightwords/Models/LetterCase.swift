//
//  LetterCase.swift
//  sightwords
//
//  Created by Chris Paine on 3/12/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import Foundation

enum LetterCaseType: Int {
    case lowercase, uppercase, capitalized, random
    
    static var randomType: LetterCaseType {
        return LetterCaseType(rawValue: Int.random(in: 0..<3)) ?? .lowercase
    }
    
    func changeCase(for text: String) -> String {
        switch self {
        case .lowercase: return text.lowercased()
        case .uppercase: return text.uppercased()
        case .capitalized: return text.capitalized
        default: return text
        }
    }
}

extension String {
    func caseType(_ type: LetterCaseType) -> String {
        switch type {
        case .random: return LetterCaseType.randomType.changeCase(for: self)
        default: return type.changeCase(for: self)
        }
    }
}
