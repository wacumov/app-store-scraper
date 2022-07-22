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
            }
        }()
        let url = "\(baseURL)/rss/\(feedTitle)/\(genre)limit=\(limit)/json?cc=\(country.rawValue.lowercased())"
        let feed: Feed = try await get(url)
        return .init(applications: feed.content.entry ?? [])
    }

    public func searchApplications(
        _ term: String,
        country: Country = .US,
        limit: Int = 10
    ) async throws -> [Application] {
        let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? term
        let url = "\(baseURL)/search?term=\(encodedTerm)&country=\(country.rawValue.lowercased())&limit=\(limit)&entity=software"
        let result: SearchResult = try await get(url)
        return result.applications
    }

    public func getApplication(
        _ id: Int,
        country: Country = .US
    ) async throws -> Application? {
        let url = "\(baseURL)/\(country.rawValue.lowercased())/lookup?id=\(id)"
        let result: SearchResult = try await get(url)
        return result.applications.first
    }

    // MARK: - Private

    private let baseURL = "https://itunes.apple.com"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    private func get<T: Decodable>(_ url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let data = try await session.data(for: request)
        return try decoder.decode(T.self, from: data)
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

    private struct Feed: Codable {
        let content: Entries

        enum CodingKeys: String, CodingKey {
            case content = "feed"
        }

        struct Entries: Codable {
            let entry: [Ranking.Application]?
        }
    }

    private struct SearchResult: Codable {
        let applications: [Application]

        enum CodingKeys: String, CodingKey {
            case applications = "results"
        }
    }
}

private extension URLSession {
    func data(for request: URLRequest) async throws -> Data {
        var dataTask: URLSessionDataTask?
        let onCancel = {
            dataTask?.cancel()
        }
        return try await withTaskCancellationHandler(
            handler: {
                onCancel()
            },
            operation: {
                try await withCheckedThrowingContinuation { continuation in
                    dataTask = self.dataTask(with: request) { data, _, error in
                        guard let data = data else {
                            let error = error ?? URLError(.badServerResponse)
                            return continuation.resume(throwing: error)
                        }
                        continuation.resume(returning: data)
                    }
                    dataTask?.resume()
                }
            }
        )
    }
}
