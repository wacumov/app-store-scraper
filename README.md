# AppStoreScraper

A library to scrape application data from the App Store.

## Installation

AppStoreScraper is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it within another Swift package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/wacumov/app-store-scraper.git", from: "0.1.0")
    ],
    ...
)
```

If you’d like to use AppStoreScraper within an iOS, macOS, watchOS or tvOS app, then use Xcode’s `File > Add Packages...` menu command to add it to your project.

Then import AppStoreScraper wherever you’d like to use it:

```swift
import AppStoreScraper
```

For more information on how to use the Swift Package Manager, check out [its official documentation](https://swift.org/package-manager).