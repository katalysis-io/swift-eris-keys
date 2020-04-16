import XCTest
@testable import ErisKeys

class ErisKeysTests: XCTestCase {
    func testSignedMessage() {
        
        guard let key = ErisKey(seed: "AA5F6846072570B270F2C1F0BDA63C55DDDAE2567D33202523DECFA75FC6C39C".toByteArray()!) else {
            XCTAssert(false, "Problems creating key")
            return
        }
        let pubKey: [UInt8] = "3D19628DF37B8F4479248909BC6570B266B067B765307631B7EF39EC076FAF44".toByteArray()!
        let account = ErisKey.account(pubKey)
        XCTAssertEqual(account, key.account)
        XCTAssertEqual(pubKey, key.pubKey)
        let msgArray: [UInt8] = Array("Hello Marmots!".utf8)
        
        let s = key.sign(msgArray)
        print(s.reduce("", { (r, u) -> String in
            return r + String(format: "%02X", u)
        }))
        
        let signed: [UInt8] = "47AF2A262B059BC3F683492CE9E3072F3F730A8628707665F5B905367F5F08DA92262A1E4AAA7249F0E69A67B89FE0006F76892FE70397874CAC7B133A950C0F".toByteArray()!
        
        
        XCTAssertTrue(ErisKey.verify(pubKey, msgArray, s))
        XCTAssertTrue(ErisKey.verify(pubKey, msgArray, signed))
    }


    static var allTests : [(String, (ErisKeysTests) -> () throws -> Void)] {
        return [
            ("testExample", testSignedMessage),
        ]
    }
}


// pub: fffd1f5f62c1b74554e3d2539
// priv: 2cc3656517237784d27e4078e75fffd1f5f62c1b74554e3d2539


//priv: 2a677c496b6c7e6862716c4b754375337a669714d2d7d75336260a2b1d
//pub: 754375337a669714d2d7d75336260a2b1d
