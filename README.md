This library is made possible by the work of the following people/teams:
- Eris Industries (https://erisindustries.com)
- Go team ()
- SUPERCOP team (http://ed25519.cr.yp.to/)
- Sjors (https://github.com/CryptoCoinSwift/RIPEMD-Swift)
- Marcin Krzyzanowski(https://github.com/krzyzanowskim/CryptoSwift)
- rnapier (https://github.com/RNCryptor/RNCryptor)
- IBM BlueCryptor team (https://github.com/IBM-Swift/BlueCryptor)

The source code and accompanying files are provided under the Apache v2 license (or respective license for prior work).
This framework provides generation, signing and verification capabilities of the Eris Keys (ED25519/RipeMD160) in Swift.

Version: 0.3.5

Usage: In a standard Swift Package Manager directory tree:
in Package.swift:
```swift
import PackageDescription

let package = Package(
    name: "ErisKeysTest",
    dependencies: [ .Package(url: "git@gitlab.com:katalysis/ErisKeys.git", majorVersion: 0, minor: 3),
]
)
```

in Sources/main.swift
```swift
import Foundation
import ErisKeys

// cryptographically secure random generated Array<UInt8> of length 32. 
let privKS: [byte] = [0x19,0x8C,0x02,0xC9,0xE2,0xA9,0x38,0xE8,0x55,0xF8,0x25,0xB3,0xB0,0xDB,0x06,0xD5,0xD8,0xA1,0xC5,0x2A,0xE4,0xB6,0xA2,0x93,0x4B,0x50,0xDC,0xFB,0xB0,0x89,0xE7,0x99]

let ek = ErisKey(seed: privKS)

print(ek.pubKeyStr)
print(ek.account

let message: [byte] = [0xD0,0x0A,0xC3,0x26,0x76,0x6F,0x69,0x63,0x69,0x20,0x75,0x6E,0x20,0x74,0x65,0x78,0x74,0x65,0x20,0x64,0x65,0x20,0x33,0x32,0x20,0x63,0x68,0x61,0x72,0x61,0x63,0x74,0x65,0x72,0x65,0x73,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xF2,0x14,0x9A,0x1E,0xC4,0x94,0xD9,0x46,0x58,0x1A,0xC4,0x53,0x21,0xA0,0xE5,0x45,0x57,0x3D,0x2C,0x4C]

let sig = ek.sign(message)

print(ek.signAsStr(message))

// Signature verification (using Ed25519.Verify(,,,))
if (Verify(ek.pubKey, message, sig)) {
  print("Signature is verified!")
}
```

Supported toolchain:
3.0.2 (Xcode 8.3)

Supported plaftorms:
- macOS
- Linux
- for iOS support, please use version 0.1.0 (swift 2.2, cocoapods enabled)