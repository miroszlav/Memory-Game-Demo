import SwiftUI

struct ContentView: View {
    @State private var viewModel = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            headerView
            gameGridView
            newGameButton
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("game_title").font(.title).bold()
                Text("time_label \(viewModel.timeFormatted)")
                    .font(.caption)
                    .monospacedDigit()
            }
            Spacer()
            Text("points_label \(viewModel.score)")
                .font(.title2)
                .monospacedDigit()
        }
        .padding(.horizontal)
    }
    
    private var gameGridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding()
        }
    }
    
    private var newGameButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                viewModel.startNewGame()
            }
        }) {
            Text("new_game_button")
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20).fill(.white)
                RoundedRectangle(cornerRadius: 20).strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }
            .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
            .opacity(card.isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: 20).fill(.blue)
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(card.isFaceUp ? 180 : 0), axis: (0, 1, 0))
        .animation(.default, value: card.isFaceUp)
        .opacity(card.isMatched ? 0 : 1)
    }
}

#Preview {
    ContentView()
}
