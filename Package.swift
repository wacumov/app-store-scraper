// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "AppStoreScraper",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(
            name: "AppStoreScraper",
            targets: ["AppStoreScraper"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppStoreScraper",
            dependencies: []
        ),
        .testTarget(
            name: "AppStoreScraperTests",
            dependencies: ["AppStoreScraper"]
        ),
    ]
)
