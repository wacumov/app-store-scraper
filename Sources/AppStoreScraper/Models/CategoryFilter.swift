public enum CategoryFilter: RawRepresentable, Equatable, Hashable, CaseIterable {
    case allApps
    case category(Category)

    public static var allCases: [CategoryFilter] {
        return [CategoryFilter.allApps] + Category.allCases.map {
            CategoryFilter.category($0)
        }
    }

    public typealias RawValue = Int

    public init?(rawValue: Int) {
        guard
            let category = Category(rawValue: rawValue)
        else {
            self = .allApps
            return
        }
        self = .category(category)
    }

    public var rawValue: Int {
        switch self {
        case .allApps: return 0
        case let .category(category): return category.rawValue
        }
    }

    public var name: String {
        switch self {
        case .allApps: return "All apps"
        case let .category(category): return category.name
        }
    }
}
