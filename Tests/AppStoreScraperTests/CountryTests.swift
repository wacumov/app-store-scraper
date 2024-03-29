import AppStoreScraper
import XCTest

final class CountryTests: XCTestCase {
    func testCountryName() async throws {
        let country = Country.EE
        XCTAssertEqual(country.name, "Estonia")
    }
}
