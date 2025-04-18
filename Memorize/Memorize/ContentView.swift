//
//  ContentView.swift
//  Memorize
//
//  Created by Anirudh on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "🎃", "🕷️", "😈"]
    var body: some View {
        
       
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .padding()
        .foregroundStyle(.orange)
        
        
    }
}

struct CardView : View {
    let content: String
    @State var isFaceUp = true

  
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
    
            	
            if isFaceUp {
                    base.foregroundStyle(.white)
                    base.strokeBorder(lineWidth: 2)

                Text(content).font(.largeTitle)
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
