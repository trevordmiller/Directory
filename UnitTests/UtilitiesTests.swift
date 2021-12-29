import XCTest
@testable import Directory

final class FormatBirthdateTests: XCTestCase {
    func testConvertsValidBirthdates() {
        XCTAssertEqual(formatBirthdate(date: "1900-01-23"), "01/23/1900")
    }

    func testHasEmptyStringForInvalidFormatting() {
        XCTAssertEqual(formatBirthdate(date: "1-2-1903"), "")
    }

    func testHasEmptyStringForInvalidDates() {
        XCTAssertEqual(formatBirthdate(date: "1900-23-23"), "")
    }
}

final class CombineNamesTests: XCTestCase {
    func testHasSpaceBetweenFirstAndLastName() {
        XCTAssertEqual(combineNames(firstName: "Jane", lastName: "Doe"), "Jane Doe")
    }

    func testOmitsSpaceWithEmptyLastName() {
        XCTAssertEqual(combineNames(firstName: "Jane", lastName: ""), "Jane")
    }
}
