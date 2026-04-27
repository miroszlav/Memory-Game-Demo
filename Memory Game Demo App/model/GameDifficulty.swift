import Foundation

enum GameDifficulty: Int, CaseIterable {
    case easy = 6
    case medium = 8
    case hard = 15
    
    var label: String {
        switch self {
        case .easy: return "difficulty_easy"
        case .medium: return "difficulty_medium"
        case .hard: return "difficulty_hard"
        }
    }
}
