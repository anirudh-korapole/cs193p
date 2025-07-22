//
//  ContentView.swift
//  Memorize
//
//  Created by Anirudh on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹","😱","☠️","🍭"]
    
    
    
    
    var body: some View {
        
        ScrollView {
            cards
        }
        .padding()
        
        
    }
    

    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundStyle(.orange)
            
        }
    }
    
    struct CardView : View {
        let content: String
        @State var isFaceUp = false
        
        
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                
                
                Group {
                    base.foregroundStyle(.white)
                    base.strokeBorder(lineWidth: 2)
                    
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
                
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }
    
    
    
    
    
    
}





#Preview {
    ContentView()
//    SafeAreaSizeView()
            
}




