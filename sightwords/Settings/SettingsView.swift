//
//  SettingsView.swift
//  sightwords
//
//  Created by Chris Paine on 2/17/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userData: UserData

    @Binding var showSettingsScreen: Bool
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: $userData.showCardNumber) {
                        Text("Show card number")
                    }
                    
                    Toggle(isOn: $userData.undoLastCardRemove) {
                        Text("Tap to show last card")
                    }
                    
                    if userData.undoLastCardRemove {
                        HStack {
                            Spacer()
                            Stepper("\(userData.tapsToUndoCardRemoved) Taps required", value: $userData.tapsToUndoCardRemoved, in: 0...10)
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: EditCardsView().environmentObject(userData)) {
                        Text("Edit Cards")
                        Spacer()
                        Text("\(userData.cards?.count ?? 0)")
                    }.disabled(true)
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing:
                Button("Close") {
                    self.showSettingsScreen.toggle()
                }
            )
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        SettingsView(showSettingsScreen: .constant(true))
            .environmentObject(UserData())
      }
   }
}
#endif