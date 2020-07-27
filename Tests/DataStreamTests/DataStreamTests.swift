import XCTest
@testable import DataStream

final class DataStreamTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DataStream().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
