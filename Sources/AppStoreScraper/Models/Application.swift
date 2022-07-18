public struct Application: Codable {
    public let id: Int
    public let bundleId: String

    public let name: String
    public let description: String

    public let iconUrl60: String
    public let iconUrl100: String
    public let iconUrl512: String

    public let screenshotUrls: [String]
    public let ipadScreenshotUrls: [String]

    public let primaryCategoryName: String
    public let primaryCategoryId: Int
    public let categories: [String]
    public let categoryIds: [String]

    public let languageCodes: [String]

    public let fileSizeBytes: String
    public let minimumOsVersion: String
    public let supportedDevices: [String]

    public let developerId: Int
    public let developerName: String
    public let developerUrl: String?

    public let price: Double?
    public let currency: String
    public let formattedPrice: String?

    public let releaseDate: String
    public let currentVersionReleaseDate: String
    public let version: String
    public let releaseNotes: String?

    public let advisories: [String]
    public let contentAdvisoryRating: String
    public let appContentRating: String

    public enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case bundleId

        case name = "trackName"
        case description

        case iconUrl60 = "artworkUrl60"
        case iconUrl100 = "artworkUrl100"
        case iconUrl512 = "artworkUrl512"

        case screenshotUrls, ipadScreenshotUrls

        case primaryCategoryName = "primaryGenreName"
        case primaryCategoryId = "primaryGenreId"
        case categories = "genres"
        case categoryIds = "genreIds"

        case languageCodes = "languageCodesISO2A"

        case fileSizeBytes, minimumOsVersion, supportedDevices

        case developerId = "artistId"
        case developerName = "artistName"
        case developerUrl = "sellerUrl"

        case price, currency, formattedPrice
        case releaseDate, currentVersionReleaseDate, version, releaseNotes

        case advisories, contentAdvisoryRating
        case appContentRating = "trackContentRating"
    }
}
