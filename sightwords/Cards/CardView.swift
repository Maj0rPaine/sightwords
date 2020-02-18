//
//  CardView.swift
//  sightwords
//
//  Created by Chris Paine on 2/6/20.
//  Copyright © 2020 Chris Paine. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var settings: UserSettings

    let card: Card
    let index: Int
    
    var removal: (() -> Void)? = nil
        
    @State private var offset = CGSize.zero
    //@State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .fill(Color.white)
            
            if settings.showCardNumber {
                VStack {
                    HStack {
                        Spacer()
                        Text("\(index)")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    Spacer()
                }
            }
                
            VStack(alignment: .center) {
                Text(card.title)
                    .font(.system(size: 100))
                    .bold()
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 75, leading: 0, bottom: 75, trailing: 0))
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
                    //self.feedback.prepare()
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        //self.feedback.notificationOccurred(.success)
                        self.removal?()
                    } else {
                        withAnimation {
                            self.offset = .zero
                        }
                    }
                }
        )
    }
}
