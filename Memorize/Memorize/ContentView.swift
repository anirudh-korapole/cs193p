//
//  ContentView.swift
//  Memorize
//
//  Created by Anirudh on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundStyle(.orange)
        
        
    }
}

struct CardView : View {
    @State var isFaceUp = false
  
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
    
            	
            if isFaceUp {
                    base.foregroundStyle(.white)
                    base.strokeBorder(lineWidth: 2)

                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
