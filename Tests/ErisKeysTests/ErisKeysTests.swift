import XCTest
@testable import ErisKeys

class ErisKeysTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ErisKeys().text, "Hello, World!")
    }


    static var allTests : [(String, (ErisKeysTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
