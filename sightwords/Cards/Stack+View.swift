//
//  Stack+View.swift
//  sightwords
//
//  Created by Chris Paine on 3/11/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int, maxOffset: CGFloat = 3) -> some View {
        let offset = CGFloat(total - position)

        guard offset <= maxOffset else {
            return self.offset(CGSize(width: 0, height: maxOffset * -10))
        }

        return self.offset(CGSize(width: 0, height: offset * -10))
    }
}
