This library is made possible by the work of the following people/teams:
Eris Industries (https://erisindustries.com)
Go team ()
SUPERCOP team (http://ed25519.cr.yp.to/)
Sjors (https://github.com/CryptoCoinSwift/RIPEMD-Swift)
rnapier (https://github.com/RNCryptor/RNCryptor)
The source code and accompanying files are provided under the Apache v2 license (or respective license for prior work).
This framework provides generation, signing and verification capabilities of the Eris Keys (ED25519/RipeMD160) in Swift.

Version: 0.3.1

Usage:
```swift
import Foundation
import ErisKeys
import Ed25519

print("Hello, World!")

let privKS1: [byte] = [0x19,0x8C,0x02,0xC9,0xE2,0xA9,0x38,0xE8,0x55,0xF8,0x25,0xB3,0xB0,0xDB,0x06,0xD5,0xD8,0xA1,0xC5,0x2A,0xE4,0xB6,0xA2,0x93,0x4B,0x50,0xDC,0xFB,0xB0,0x89,0xE7,0x99]

//print(privKS1.toString().toByteArray()?.toString())
//print(privKS1.toString().toData()?.toHexString())
let ek1 = ErisKey(seed: privKS1)

if (ek1.pubKey().toString() == "6D9B43FA3798272790731D2D1DD94A4589E95F11B6FC9A8E9399E801165C3F44") {
  print ("Pub key ok")
}
if (ek1.account() == "8054EAB7FF4FDDE15E5F67DEBE6363642980DF64") {
  print ("Account ok")
}
print (ek1.pubKey().toString())
print (ek1.account())

let message: [byte] = [0xD0,0x0A,0xC3,0x26,0x76,0x6F,0x69,0x63,0x69,0x20,0x75,0x6E,0x20,0x74,0x65,0x78,0x74,0x65,0x20,0x64,0x65,0x20,0x33,0x32,0x20,0x63,0x68,0x61,0x72,0x61,0x63,0x74,0x65,0x72,0x65,0x73,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xF2,0x14,0x9A,0x1E,0xC4,0x94,0xD9,0x46,0x58,0x1A,0xC4,0x53,0x21,0xA0,0xE5,0x45,0x57,0x3D,0x2C,0x4C]

let sig = ek1.sign(message)

if (sig.toString() == "0AE0FBC251B5EE1C6BA588A8334ECA218A99392BB27240A1B44018F78809C99A82C44CFC68630A37536294D9ACF748415E3E099146FB959F9BFA7458BCE12401") {
  print ("Signature is correct")
}


print (sig.toString())
if (Verify(ek1.pubKey(), message, sig)) {
  print("hurra, the signature is verified!")
} else {
  print("booh, the signature is incorrect!")
}


```

Supported toolchain:
3.0-PREVIEW-6 (Xcode 8.0 Beta 6)

Supported plaftorms:
- macOS
- Linux
- for iOS support, please use version 0.1.0 (swift 2.2, cocoapods enabled)