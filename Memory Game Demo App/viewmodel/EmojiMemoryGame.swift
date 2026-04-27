import SwiftUI

@Observable
class EmojiMemoryGame {
    
    private static let defaultPairs = 8
    
    private var model: MemoryGame
    private var timer: Timer?
    private var secondsElapsed: Int
    
    var cards: [Card] { model.cards }
    var score: Int { model.score }
    
    var timeFormatted: String {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    init() {
        self.model = MemoryGame(numberOfPairs: EmojiMemoryGame.defaultPairs)
        self.secondsElapsed = 0
        startTimer()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = MemoryGame(numberOfPairs: EmojiMemoryGame.defaultPairs)
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        secondsElapsed = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.secondsElapsed += 1
        }
    }
}
