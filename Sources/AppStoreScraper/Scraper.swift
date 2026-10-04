import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct Scraper {
    public init() {}

    public func getRanking(
        _ rankingType: RankingType,
        country: Country = .US,
        categoryFilter: CategoryFilter = .allApps,
        limit: Int = 10
    ) async throws -> Ranking {
        let feedTitle = makeFeedTitle(rankingType)
        let genre: String = {
            switch categoryFilter {
            case .allApps:
                return ""
            case let .category(category):
                return "genre=\(category.rawValue)/"
            case let .gamesSubcategory(subcategory):
                return "genre=\(subcategory.rawValue)/"
            }
        }()
        let url = "\(baseURL)/rss/\(feedTitle)/\(genre)limit=\(limit)/json?cc=\(country.rawValue.lowercased())"
        let feed: Feed = try await get(url)
        return .init(applications: feed.content.entry?.toArray ?? [])
    }

    public func searchApplications(
        _ term: String,
        country: Country = .US,
        language: Language? = nil,
        limit: Int = 10
    ) async throws -> [Application] {
        let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? term
        let language = makeLanguage(language, country: country)
        let url = "\(baseURL)/search?term=\(encodedTerm)&country=\(country.rawValue.lowercased())&limit=\(limit)&entity=software\(language)"
        let result: SearchResult = try await get(url)
        return result.applications
    }

    public func getApplication(
        _ id: Int,
        country: Country = .US,
        language: Language? = nil
    ) async throws -> Application? {
        let language = makeLanguage(language, country: country)
        let url = "\(baseURL)/\(country.rawValue.lowercased())/lookup?id=\(id)\(language)"
        let result: SearchResult = try await get(url)
        return result.applications.first
    }

    /// Returns App Store search autocomplete suggestions for a term, in the order the store shows them.
    public func getSearchHints(
        _ term: String,
        country: Country = .US
    ) async throws -> [String] {
        guard let storefrontId = country.storefrontId else {
            throw UnsupportedCountry(country: country)
        }
        let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? term
        let url = "\(hintsURL)?clientApplication=Software&term=\(encodedTerm)"
        let data = try await getData(url, headers: ["X-Apple-Store-Front": String(storefrontId)])
        let result = try PropertyListDecoder().decode(HintsResult.self, from: data)
        return result.hints.map(\.term)
    }

    public struct UnsupportedCountry: Error {
        public let country: Country
    }

    // MARK: - Private

    private let baseURL = "https://itunes.apple.com"
    private let hintsURL = "https://search.itunes.apple.com/WebObjects/MZSearchHints.woa/wa/hints"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    private func get<T: Decodable>(_ url: String) async throws -> T {
        let data = try await getData(url)
        return try decoder.decode(T.self, from: data)
    }

    private func getData(_ url: String, headers: [String: String] = [:]) async throws -> Data {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (field, value) in headers {
            request.setValue(value, forHTTPHeaderField: field)
        }
        return try await session.data(for: request)
    }

    private func makeFeedTitle(_ rankingType: RankingType) -> String {
        let suffix: String = {
            switch rankingType {
            case .topFreeMac, .topPaidMac:
                return "apps"
            default:
                return "applications"
            }
        }()
        return [rankingType.rawValue.lowercased(), suffix].joined()
    }

    private func makeLanguage(_ language: Language?, country: Country) -> String {
        guard let language else {
            return ""
        }
        let supported = country.languages
        guard
            language != supported.main,
            supported.additional.contains(language)
        else {
            return ""
        }
        let code: String = {
            switch language {
            case .zh_Hans: return "zh_CN"
            default: return String(language.rawValue.prefix(2))
            }
        }()
        return "&lang=\(code)"
    }

    private struct Feed: Decodable {
        let content: Entries

        enum CodingKeys: String, CodingKey {
            case content = "feed"
        }

        struct Entries: Decodable {
            let entry: OneOrMany<Ranking.Application>?
        }
    }

    private struct HintsResult: Decodable {
        let hints: [Hint]

        struct Hint: Decodable {
            let term: String
        }
    }

    private struct SearchResult: Codable {
        let applications: [Application]

        enum CodingKeys: String, CodingKey {
            case applications = "results"
        }
    }
}

private enum OneOrMany<T: Decodable>: Decodable {
    case one(T)
    case many([T])

    var toArray: [T] {
        switch self {
        case let .one(item): return [item]
        case let .many(items): return items
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let many = try? container.decode([T].self) {
            self = .many(many)
        } else if let one = try? container.decode(T.self) {
            self = .one(one)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode \(OneOrMany.self)")
        }
    }
}

private extension URLSession {
    func data(for request: URLRequest) async throws -> Data {
        var dataTask: URLSessionDataTask?
        let onCancel = {
            dataTask?.cancel()
        }
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                dataTask = self.dataTask(with: request) { data, _, error in
                    guard let data else {
                        let error = error ?? URLError(.badServerResponse)
                        return continuation.resume(throwing: error)
                    }
                    continuation.resume(returning: data)
                }
                dataTask?.resume()
            }
        } onCancel: {
            onCancel()
        }
    }
}
