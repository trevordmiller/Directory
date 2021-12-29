import XCTest

class LaunchTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testRendersProfileBrowseWithData() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.staticTexts["Luke Skywalker"].exists)
        XCTAssertTrue(app.staticTexts["Darth Vader"].exists)
    }

    func testRendersProfileDetailWithData() throws {
        let app = XCUIApplication()
        app.launch()
        app.staticTexts["Kylo Ren"].tap()
        XCTAssertTrue(app.staticTexts["Born on 10/31/1987"].exists)
        XCTAssertTrue(app.staticTexts["Force Sensitive"].exists)
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
