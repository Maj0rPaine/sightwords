//
//  CardView.swift
//  sightwords
//
//  Created by Chris Paine on 2/6/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct CardNumberView: View {
    var number: String
    
    var body: some View {
        Text(number)
            .font(.title)
            .foregroundColor(.gray)
            .padding()
    }
}

struct CardTitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 90))
            .bold()
            .foregroundColor(.black)
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
    }
}

struct CardView: View {
    @EnvironmentObject var userData: UserData
    
    let card: Card
    
    let index: Int
    
    var removal: (() -> Void)? = nil
        
    @State private var offset = CGSize.zero
    
    @State private var title: String = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .fill(Color.white)
            
            if userData.showCardNumber {
                VStack {
                    HStack {
                        Spacer()
                        CardNumberView(number: "\(index)")
                    }
                    
                    Spacer()
                }
            }
            
            VStack(alignment: .center) {
                CardTitleView(title: title)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .leastNormalMagnitude)
        .padding()
        .shadow(radius: 5)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 2, y: 0)
        .gesture(
            DragGesture(minimumDistance: 10)
                .onChanged { gesture in
                    self.offset = gesture.translation
            }
            .onEnded { _ in
                if abs(self.offset.width) > 100 {
                    self.removal?()
                } else {
                    withAnimation {
                        self.offset = .zero
                    }
                }
            }
        )
        .onTapGesture(count: 1, perform: {
            withAnimation {
                self.userData.showCardNumber.toggle()
            }
        })
        .onAppear {
            self.setTitleCaseType()
        }
    }
    
    func setTitleCaseType() {
        let type = LetterCaseType(rawValue: self.userData.letterCase)
        self.title = self.card.title.caseType(type ?? .lowercase)
    }
}

#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        CardView(card: Card.example, index: 0)
            .environmentObject(UserData())
      }
   }
}
#endif
