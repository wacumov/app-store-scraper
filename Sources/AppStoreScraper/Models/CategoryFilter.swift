public enum CategoryFilter: RawRepresentable, Equatable, Hashable, CaseIterable {
    case allApps
    case category(Category)
    case gamesSubcategory(GamesSubcategory)

    public static var allCases: [CategoryFilter] {
        [CategoryFilter.allApps] + Category.allCases.map {
            CategoryFilter.category($0)
        } + GamesSubcategory.allCases.map {
            CategoryFilter.gamesSubcategory($0)
        }
    }

    public typealias RawValue = Int

    public init?(rawValue: Int) {
        if let category = Category(rawValue: rawValue) {
            self = .category(category)
        } else if let subcategory = GamesSubcategory(rawValue: rawValue) {
            self = .gamesSubcategory(subcategory)
        } else if rawValue == 0 {
            self = .allApps
        } else {
            return nil
        }
    }

    public var rawValue: Int {
        switch self {
        case .allApps: return 0
        case let .category(category): return category.rawValue
        case let .gamesSubcategory(subcategory): return subcategory.rawValue
        }
    }

    public var name: String {
        switch self {
        case .allApps: return "All apps"
        case let .category(category): return category.name
        case let .gamesSubcategory(subcategory): return "Games / \(subcategory.name)"
        }
    }
}
