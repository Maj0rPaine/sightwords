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
        guard let cards = Card.load() else { return }
        self.cards = cards.sorted { $0.title.caseInsensitiveCompare($1.title) == .orderedAscending }
    }

    func addCard(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        guard trimmedTitle.isEmpty == false else { return }

        let card = Card(title: trimmedTitle)
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
        
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new card")) {
                    TextField("Title", text: $newTitle)
                    Button("Add card") {
                        self.editCardsViewModel.addCard(title: self.newTitle)
                    }
                }

                Section {
                    ForEach(0..<editCardsViewModel.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(self.editCardsViewModel.cards[index].title)
                                .font(.headline)
                        }
                    }
                    .onDelete(perform: { offsets in
                        self.editCardsViewModel.cards.remove(atOffsets: offsets)
                    })
                }
            }
            .navigationBarTitle("Edit Cards")
            .listStyle(GroupedListStyle())
            .onAppear(perform: editCardsViewModel.loadCards)
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
