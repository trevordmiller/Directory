import XCTest
@testable import Directory

final class FormatBirthdateTests: XCTestCase {
    func testConvertsValidBirthdates() {
        let result = formatBirthdate(date: "1900-01-23")
        let expected = "01/23/1900"
        XCTAssertEqual(result, expected)
    }

    func testHasEmptyStringForInvalidFormatting() {
        let result = formatBirthdate(date: "1-2-1903")
        let expected = ""
        XCTAssertEqual(result, expected)
    }

    func testHasEmptyStringForInvalidDates() {
        let result = formatBirthdate(date: "1900-23-23")
        let expected = ""
        XCTAssertEqual(result, expected)
    }
}

final class CombineNamesTests: XCTestCase {
    func testHasSpaceBetweenFirstAndLastName() {
        let result = combineNames(firstName: "Jane", lastName: "Doe")
        let expected = "Jane Doe"
        XCTAssertEqual(result, expected)
    }

    func testOmitsSpaceWithEmptyLastName() {
        let result = combineNames(firstName: "Jane", lastName: "")
        let expected = "Jane"
        XCTAssertEqual(result, expected)
    }
}
