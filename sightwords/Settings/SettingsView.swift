//
//  SettingsView.swift
//  sightwords
//
//  Created by Chris Paine on 2/17/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings

    @Binding var showSettingsScreen: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $settings.showCardNumber) {
                    Text("Show card number")
                }
                
                Toggle(isOn: $settings.undoLastCardRemove) {
                    Text("Tap to show last card")
                }
                
                if settings.undoLastCardRemove {
                    HStack {
                        Spacer()
                        Stepper("\(settings.tapsToUndoCardRemoved) Taps required", value: $settings.tapsToUndoCardRemoved, in: 0...10)
                    }
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing:
                Button("Close") {
                    self.showSettingsScreen = false
                }
            )
        }
    }
}
