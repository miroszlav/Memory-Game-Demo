//
//  Memory_Game_Demo_AppTests.swift
//  Memory Game Demo AppTests
//
//  Created by Miroszláv Jani on 26.04.2026.
//

import Testing
@testable import Memory_Game_Demo_App

struct Memory_Game_Demo_AppTests {

    @Test func gameStartsAllFaceDown() {
            let game = MemoryGame(numberOfPairs: 2)
            
            for card in game.cards {
                #expect(card.isFaceUp == false)
            }
        }

        @Test mutating func choosingCardFlipsIt() {
            var game = MemoryGame(numberOfPairs: 2)
            let firstCard = game.cards[0]
            
            game.choose(firstCard)
            
            #expect(game.cards[0].isFaceUp == true)
        }

}
