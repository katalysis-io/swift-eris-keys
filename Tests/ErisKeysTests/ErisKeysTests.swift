import XCTest
@testable import ErisKeys

class ErisKeysTests: XCTestCase {
    func testSignedMessage() {
        
        guard let key = ErisKey(seed: "744D57D112D795F2C4CEBA22EEC09C9DC16FAFB0E7F737AB3CB50EC92F9C6581".toByteArray()!) else {
            XCTAssert(false, "Problems creating key")
            return
        }
        let pubKey: [UInt8] = "A940E6820B6CB783575B20F0109AF934726C521A12DDDB3D822141402C39C850C41510D45A95A8F9DC52309C47E113FE79595CCDC54F8E6F0137DDA68EEA0177".toByteArray()!
        let account = ErisKey.account(pubKey)
        XCTAssertEqual(account, key.account)
        XCTAssertEqual(pubKey, key.pubKey)
        let msgArray: [UInt8] = Array("""
{"content":"e4c86e8e3a76434729b1bd03cd588765d11d2bb15e9b5f4408ff375c13c65dd0","participant":"A940E6820B6CB783575B20F0109AF934726C521A12DDDB3D822141402C39C850C41510D45A95A8F9DC52309C47E113FE79595CCDC54F8E6F0137DDA68EEA0177"}
""".utf8)
        
        let s = key.sign(msgArray)
        print(s.reduce("", { (r, u) -> String in
            return r + String(format: "%02X", u)
        }))
        
        let signed: [UInt8] = "26B0BB48F137FEA5732E2E42A685CEF42418FAEDB3C354036915D4B421318160560C0A00820DE282A75C91E06001742981BFB34FEEBF3603E16A3DE923D8786700".toByteArray()!
        
        
        XCTAssertTrue(ErisKey.verify(pubKey, msgArray, s))
        XCTAssertTrue(ErisKey.verify(pubKey, msgArray, signed))
    }


    static var allTests : [(String, (ErisKeysTests) -> () throws -> Void)] {
        return [
            ("testExample", testSignedMessage),
        ]
    }
}
