import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            headerView
            Spacer(minLength: 10)
            gameGridView
            Spacer(minLength: 10)
            difficultyPicker
            newGameButton
        }
    }
    
    @State private var viewModel = EmojiMemoryGame()
    
    private var columns: [GridItem] {
        let minWidth: CGFloat = switch viewModel.difficulty {
        case .easy: 120
        case .medium: 80
        case .hard: 60
        }
        return [GridItem(.adaptive(minimum: minWidth))]
    }
    
    private func calculateCardWidth(totalWidth: CGFloat, totalHeight: CGFloat, count: Int) -> CGFloat {
        let area = totalWidth * totalHeight
        let cardArea = area / CGFloat(count) * 0.8
        let width = sqrt(cardArea / 1.3)
        
        return min(max(width, 40), 150)
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
        GeometryReader { geometry in
            let cardWidth = calculateCardWidth(
                totalWidth: geometry.size.width,
                totalHeight: geometry.size.height,
                count: viewModel.cards.count
            )
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth), spacing: 5)], spacing: 5) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .frame(width: cardWidth, height: cardWidth * 1.3)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    private var difficultyPicker: some View {
        Picker("difficulty_label", selection: $viewModel.difficulty) {
            ForEach(GameDifficulty.allCases, id: \.self) { level in
                Text(LocalizedStringKey(level.label)).tag(level)
            }
        }
        .pickerStyle(.segmented)
        .padding()
        .onChange(of: viewModel.difficulty) {
            viewModel.startNewGame()
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
                Image(systemName: card.content)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .foregroundColor(.green)
                    .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
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
