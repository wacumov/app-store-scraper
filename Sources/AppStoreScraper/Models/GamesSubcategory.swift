public enum GamesSubcategory: Int, Codable, CaseIterable {
    case action = 7001
    case adventure = 7002
    case casual = 7003
    case board = 7004
    case card = 7005
    case casino = 7006
    case family = 7009
    case music = 7011
    case puzzle = 7012
    case racing = 7013
    case rolePlaying = 7014
    case simulation = 7015
    case sports = 7016
    case strategy = 7017
    case trivia = 7018
    case word = 7019

    public var name: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .casual: return "Casual"
        case .board: return "Board"
        case .card: return "Card"
        case .casino: return "Casino"
        case .family: return "Family"
        case .music: return "Music"
        case .puzzle: return "Puzzle"
        case .racing: return "Racing"
        case .rolePlaying: return "Role Playing"
        case .simulation: return "Simulation"
        case .sports: return "Sports"
        case .strategy: return "Strategy"
        case .trivia: return "Trivia"
        case .word: return "Word"
        }
    }
}
