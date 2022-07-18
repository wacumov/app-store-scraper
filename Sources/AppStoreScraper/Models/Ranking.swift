public struct Ranking: Codable {
    public let applications: [Application]

    public struct Application: Codable {
        public let name: Name
        public let icons: [Icon]
        public let price: Price
        public let developer: Developer
        public let releaseDate: ReleaseDate
        public let summary: Summary?
        public let rights: Rights
        public let id: ID
        public let category: Category

        enum CodingKeys: String, CodingKey {
            case name = "im:name"
            case icons = "im:image"
            case price = "im:price"
            case developer = "im:artist"
            case releaseDate = "im:releaseDate"
            case summary, rights, id, category
        }

        public typealias Name = Label

        public struct Icon: Codable {
            public let url: String
            public let attributes: Attributes

            enum CodingKeys: String, CodingKey {
                case url = "label"
                case attributes
            }

            public struct Attributes: Codable {
                public let height: String
            }
        }

        public struct Price: Codable {
            public let attributes: Attributes

            public struct Attributes: Codable {
                public let amount: String
                public let currency: String
            }
        }

        public typealias Developer = Label
        public typealias ReleaseDate = Label
        public typealias Summary = Label
        public typealias Rights = Label

        public struct ID: Codable {
            public let attributes: Attributes

            public struct Attributes: Codable {
                public let id: String
                public let bundleId: String

                public enum CodingKeys: String, CodingKey {
                    case id = "im:id"
                    case bundleId = "im:bundleId"
                }
            }
        }

        public struct Category: Codable {
            public let attributes: Attributes

            public struct Attributes: Codable {
                public let id: String
                public let name: String

                public enum CodingKeys: String, CodingKey {
                    case id = "im:id"
                    case name = "label"
                }
            }
        }

        public struct Label: Codable {
            public let value: String

            public enum CodingKeys: String, CodingKey {
                case value = "label"
            }
        }
    }
}
