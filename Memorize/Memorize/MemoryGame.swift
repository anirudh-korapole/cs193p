//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Anirudh on 08/07/25.
// model

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent ) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    func choose(_ card: Card) {
        
    }
    
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
    }
}
