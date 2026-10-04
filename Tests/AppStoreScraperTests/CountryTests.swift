import AppStoreScraper
import XCTest

final class CountryTests: XCTestCase {
    func testCountryName() {
        let country = Country.EE
        XCTAssertEqual(country.name, "Estonia")
    }

    func testStorefrontId() {
        XCTAssertEqual(Country.US.storefrontId, 143441)
        XCTAssertEqual(Country.EE.storefrontId, 143518)
    }
}
