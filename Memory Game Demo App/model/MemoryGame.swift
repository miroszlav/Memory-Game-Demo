import Foundation

struct MemoryGame {
    private(set) var cards: [Card]
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairs: Int) {
        cards = []
        let emojis = ["A", "B", "C", "D", "E", "F", "G", "H"]
        for i in 0..<numberOfPairs {
            let content = emojis[i % emojis.count]
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    score = max(0, score - 1)
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
}
