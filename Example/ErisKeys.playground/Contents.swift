//  Created by Alex Tran Qui on 30/06/16.
//  Copyright © 2016 Katalysis / Alex Tran Qui (alex.tranqui@gmail.com). All rights reserved.
//
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

import Security
import ErisKeys


// Secure random bytes generation (Apple platforms)
let bytesCount = 32 // number of bytes
var randomNum = "" // hexadecimal version of randomBytes
var randomBytes = [UInt8](count: bytesCount, repeatedValue: 0) // array to hold randoms bytes

// Gen random bytes
SecRandomCopyBytes(kSecRandomDefault, bytesCount, &randomBytes)

// Turn randomBytes into array of hexadecimal strings
// Join array of strings into single string
randomNum = randomBytes.map({String(format: "%02hhX", $0)}).joinWithSeparator("")

print (randomNum)


// Random entropy (taken and adapted from https://github.com/miracl/milagro-crypto)
var RAW=[UInt8](count:100,repeatedValue:0)

let rng = RAND()

rng.clean();
// initialization of random seed
for i in 0..<100 {RAW[i]=UInt8(i&0xfe)}

rng.seed(100,RAW)

rng.getByte()
rng.getByte()
rng.getByte()
rng.getByte()



// ed25519
let privKS1: [byte] = [0x19,0x8C,0x02,0xC9,0xE2,0xA9,0x38,0xE8,0x55,0xF8,0x25,0xB3,0xB0,0xDB,0x06,0xD5,0xD8,0xA1,0xC5,0x2A,0xE4,0xB6,0xA2,0x93,0x4B,0x50,0xDC,0xFB,0xB0,0x89,0xE7,0x99]

var ek1 = ErisKey(seed: privKS1)

print (ek1.pubKey().toString())
print (ek1.account())

let message: [byte] = [0xD0,0x0A,0xC3,0x26,0x76,0x6F,0x69,0x63,0x69,0x20,0x75,0x6E,0x20,0x74,0x65,0x78,0x74,0x65,0x20,0x64,0x65,0x20,0x33,0x32,0x20,0x63,0x68,0x61,0x72,0x61,0x63,0x74,0x65,0x72,0x65,0x73,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xF2,0x14,0x9A,0x1E,0xC4,0x94,0xD9,0x46,0x58,0x1A,0xC4,0x53,0x21,0xA0,0xE5,0x45,0x57,0x3D,0x2C,0x4C]

let sig = ek1.sign(message)


print (sig.toString())
if (Verify(ek1.pubKey(), message, sig)) {
  print("hurra, the signature is verified!")
} else {
  print("booh, the signature is incorrect!")
}

let privKS4: [byte] = [0x57,0x6E,0x85,0x71,0xE0,0x61,0x82,0x80,0x9A,0x5D,0xB4,0xEB,0xFE,0xE9,0x78,0xA3,0x33,0xC5,0x07,0x70,0x4C,0x61,0xCD,0xDC,0x1D,0x04,0x89,0x50,0xE6,0x52,0xAF,0x52]
privKS4.count

let k = ErisKey(seed: privKS4)

print (k.pubKey().toString())
print (k.account())


let s = "{\"chain_id\":\"simplechain\",\"tx\":[2,{\"address\":\"BB43DD0FBA5829EEAACE4724A478385FB54756CD\",\"data\":\"53703F5C0000000000000000000000000000000000000000000000000000000000000064\",\"fee\":0,\"gas_limit\":1000000,\"input\":{\"address\":\"17ED8B7ECF81D49743A880FFFDA0DDB020C1D62B\",\"amount\":1,\"sequence\":19}}]}"

// associated signature (from ErisKey(privKS4)): "5D4E9905534C3E122FB10F1065D442D6BF254733D18D3D5FA599487905B21DBBB2636FFDCA657F241A8D462D1B7F26A3DBFA029DDEF3DBE3C123743E55477002"

let array: [UInt8] = Array(s.utf8)

let sgn = k.sign(array)
sgn.toString()
Verify(k.pubKey(), array, sgn)
