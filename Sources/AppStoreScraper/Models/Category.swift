public enum Category: Int, Codable, CaseIterable {
    case business = 6000
    case weather = 6001
    case utilities = 6002
    case travel = 6003
    case sports = 6004
    case socialNetworking = 6005
    case reference = 6006
    case productivity = 6007
    case photoAndVideo = 6008
    case news = 6009
    case navigation = 6010
    case music = 6011
    case lifestyle = 6012
    case healthAndFitness = 6013
    case games = 6014
    case finance = 6015
    case entertainment = 6016
    case education = 6017
    case books = 6018
    case foodAndDrink = 6023
    case shopping = 6024
    case developerTools = 6026
    case graphicsAndDesign = 6027

    public var name: String {
        switch self {
        case .business: return "Business"
        case .weather: return "Weather"
        case .utilities: return "Utilities"
        case .travel: return "Travel"
        case .sports: return "Sports"
        case .socialNetworking: return "Social Networking"
        case .reference: return "Reference"
        case .productivity: return "Productivity"
        case .photoAndVideo: return "Photo & Video"
        case .news: return "News"
        case .navigation: return "Navigation"
        case .music: return "Music"
        case .lifestyle: return "Lifestyle"
        case .healthAndFitness: return "Health & Fitness"
        case .games: return "Games"
        case .finance: return "Finance"
        case .entertainment: return "Entertainment"
        case .education: return "Education"
        case .books: return "Books"
        case .foodAndDrink: return "Food & Drink"
        case .shopping: return "Shopping"
        case .developerTools: return "Developer Tools"
        case .graphicsAndDesign: return "Graphics & Design"
        }
    }
}
