//
//  TimerView.swift
//  sightwords
//
//  Created by Chris Paine on 3/12/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    @EnvironmentObject var userData: UserData
    
    @Binding var timeRemaining: Int {
        didSet {
            if self.timeRemaining < 0 {
                self.timer.upstream.connect().cancel()
            }
        }
    }
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let tweetSoundID: SystemSoundID = 1016
    
    private let descentSoundID: SystemSoundID = 1024

    var body: some View {
        Text(description)
            .font(.title)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(color)
                    .opacity(0.75)
            .onReceive(timer) { time in
                print(time)
                if self.userData.timerSoundEnabled {
                    self.playSound()
                }
                self.updateTimeRemaining()
            }
        )
    }
}

extension TimerView {
    var description: String {
        if timeRemaining < 0 {
            return "Stopped"
        } else if timeRemaining == 0 {
            return "Times Up!"
        } else {
            return "\(timeRemaining)"
        }
    }
    
    var color: Color {
        return timeRemaining <= 3 ? .red : .green
    }
    
    func updateTimeRemaining() {
        guard self.timeRemaining > 0 else { return }
        self.timeRemaining -= 1
    }
    
    func playSound() {
        if (2...4).contains(timeRemaining) {
            AudioServicesPlaySystemSound(tweetSoundID)
        } else if timeRemaining == 1 {
            AudioServicesPlaySystemSound(descentSoundID)
        }
    }
}
