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
                Section(header: Text("Card Style")) {
                    Toggle(isOn: $userData.showCardNumber) {
                        Text("Show card number")
                    }
                    
                    Picker(selection: $userData.letterCase, label: Text("Letter case")) {
                        ForEach(0 ..< userData.letterCaseTypes.count) {
                            Text(self.userData.letterCaseTypes[$0]).tag($0)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                }
                
                Section(header: Text("Gestures")) {
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
                    NavigationLink(destination: EditCardsView().environmentObject(userData)) { // Currently broken (only navigates once) on Xcode 11.3
                        Text("Edit Cards")
                        Spacer()
                        Text("\(userData.cards.count)")
                    }.disabled(false)
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
