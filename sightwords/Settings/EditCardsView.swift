//
//  EditCardsView.swift
//  sightwords
//
//  Created by Chris Paine on 2/6/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

class EditCardsViewModel: ObservableObject {
    @Published var cards = [Card]()
    
    func loadCards() {
        self.cards = Card.load().sorted { $0.title.caseInsensitiveCompare($1.title) == .orderedAscending }
    }
    
    func addCard(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        guard trimmedTitle.isEmpty == false else { return }
        
        let card = Card(title: trimmedTitle, isSelected: false)
        cards.insert(card, at: 0)
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}

struct EditCardsView: View {
    @EnvironmentObject var userData: UserData
    
    @ObservedObject var editCardsViewModel = EditCardsViewModel()
    
    @State private var newTitle = ""
        
    private var allCardsSelected: Bool {
        return userData.cards.filter({ $0.isSelected }).count == userData.cards.count
    }
        
    var body: some View {
        List {
//            Section(header: Text("Add new card")) {
//                TextField("Title", text: $newTitle)
//                Button("Add card") {
//                    self.userData.addCard(title: self.newTitle)
//                }
//            }
            
            ForEach(0..<userData.cards.count, id: \.self) { index in
                VStack(alignment: .leading) {
                    HStack {
                        Text(self.userData.cards[index].title)
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: {
                            self.userData.cards[index]
                                .isSelected.toggle()
                        }) {
                            if self.userData.cards[index]
                                .isSelected {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
//                .onDelete(perform: { offsets in
//                    self.userData.cards.remove(atOffsets: offsets)
//                })
        }
        .navigationBarTitle("Select Cards")
        .navigationBarItems(trailing:
            Button(action: {
                self.toggleSelection()
            }) {
                Text(allCardsSelected ? "Deselect All" : "Select All")
            }
        )
        .listStyle(GroupedListStyle())
        .onAppear {
            //editCardsViewModel.loadCards
        }
    }
    
    func toggleSelection() {
        for i in self.userData.cards.indices {
            self.userData.cards[i].isSelected = false
        }
    }
}

#if DEBUG
struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditCardsView()
        }
    }
}
#endif
