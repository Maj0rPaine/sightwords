//
//  TimerView.swift
//  sightwords
//
//  Created by Chris Paine on 3/12/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @Binding var timeRemaining: Int
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("Time: \(timeRemaining)")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(self.timeRemaining <= 3 ? Color.red : Color.green)
                    .opacity(0.75)
            .onReceive(timer) { time in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
        )
    }
}
