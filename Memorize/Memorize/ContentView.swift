//
//  ContentView.swift
//  Memorize
//
//  Created by Anirudh on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTheme: String = "halloween"
    
    
    let themes: [String:Array<String>] = [
        "halloween": ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹","😱","☠️","🍭"],
        "animals": ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐷", "🐸"],
        "birds": ["🐦", "🐧", "🦅", "🦆", "🦢", "🦉", "🦤", "🪶", "🕊️", "🐤", "🐥", "🐣"],
        "food" : ["🍎", "🍌", "🍇", "🍉", "🍓", "🍍", "🥑", "🥕", "🍞", "🍕", "🍔", "🍩"]
    ]
    
    @State var emojis: [String]
    
    init() {
        self.emojis = themes["halloween"] ?? []
    }
    
    

    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0/255, green: 94/255, blue: 84/255))
            
            ScrollView {
                cards
                
            }
            Spacer()
            cardCountAdjusters
            
        }
        .padding()
        
        
    }
    
    var cardCountAdjusters: some View {
        HStack(alignment: .lastTextBaseline) {
            HStack(spacing: 30) {
                //Spacer()
                
                VStack{
                    foodTheme
                    
                }
                birdTheme
                animalsTheme
                halloweenTheme
                //Spacer()
                
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
    }
    
    
    
    
    func themeSelector(theme: String, themeName: String, symbol: String) -> some View {
        VStack(spacing: 4) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    emojis = themes[theme] ?? []
                    selectedTheme = theme
                }
                
            }, label: {
                Image(systemName: symbol)
                    .foregroundColor(selectedTheme == theme ? .orange : .blue)
                    .scaleEffect(selectedTheme == theme ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: selectedTheme)
                
            })
            
            Text(themeName).font(.caption)
        }
       
        
        
        
        
    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        
//        Button (action: {
//            cardCount += offset
//            
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
    
    
    var halloweenTheme: some View {
        themeSelector(theme: "halloween", themeName: "Halloween", symbol: "theatermasks.circle.fill")
    }
    
    var animalsTheme: some View {
        themeSelector(theme: "animals", themeName: "Animals", symbol: "pawprint.circle.fill")
    }
    
    var foodTheme: some View {
        themeSelector(theme: "food", themeName: "Food", symbol: "fork.knife.circle.fill")
    }
    
    var birdTheme: some View {
        themeSelector(theme: "birds", themeName: "Birds", symbol: "bird.circle.fill")
    }
    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
//    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        let width = 280.0 / CGFloat(cardCount) + 53.33
        return max(60, min(175, width))
    }

    
    var cards: some View {
        
        var emojiList = emojis
        for emoji in emojis {
            emojiList.append(emoji)
        }
        emojiList.shuffle()
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: 24)))]) {
            
            ForEach(0..<24, id: \.self) { index in
                CardView(content: emojiList[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundStyle(.orange)
//                CardView(content: emojiList[index])
//                    .aspectRatio(2/3, contentMode: .fit)
//                    .foregroundStyle(.orange)
                
                
    
                
                
                // if its 24, then 60
                //if its 12 then 80
                // if its 6 then 100
                // if its 4 then 120
                
                
                
                
                
            }
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


import SwiftUI

struct SafeAreaSizeView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Text("🛡️ Safe Area Size")
                    .font(.title2)
                    .bold()
                Text("Width: \(geometry.size.width, specifier: "%.0f")")
                Text("Height: \(geometry.size.height, specifier: "%.0f")")
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}







#Preview {
    ContentView()
//    SafeAreaSizeView()
            
}




