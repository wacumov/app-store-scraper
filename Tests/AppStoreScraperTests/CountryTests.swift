import AppStoreScraper
import XCTest

final class CountryTests: XCTestCase {
    func testCountryName() {
        let country = Country.EE
        XCTAssertEqual(country.name, "Estonia")
    }
}
