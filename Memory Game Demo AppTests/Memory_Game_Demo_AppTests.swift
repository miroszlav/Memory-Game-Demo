import Testing
@testable import Memory_Game_Demo_App

struct Memory_Game_Demo_AppTests {

    @Test func gameStartsAllFaceDown() {
        let game = MemoryGame(numberOfPairs: 2)
            
        for card in game.cards {
            #expect(card.isFaceUp == false)
        }
    }

    @Test func choosingCardFlipsIt() {
        var game = MemoryGame(numberOfPairs: 2)
        let firstCard = game.cards[0]
            
        game.choose(firstCard)
            
        #expect(game.cards[0].isFaceUp == true)
    }
    
    @Test func matchingPairScoresTwoPoints() {
        var game = MemoryGame(numberOfPairs: 2)
        let first = game.cards[0]
        let match = game.cards.first { $0.content == first.content && $0.id != first.id }!

        game.choose(first)
        game.choose(match)

        #expect(game.score == 2)
        #expect(game.cards.filter(\.isMatched).count == 2)
    }

    @Test func mismatchNeverDropsScoreBelowZero() {
        var game = MemoryGame(numberOfPairs: 2)
        let first = game.cards[0]
        let other = game.cards.first { $0.content != first.content }!

        game.choose(first)
        game.choose(other)

        #expect(game.score == 0)
    }

}
