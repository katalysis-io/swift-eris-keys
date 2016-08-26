//
//  erisKey.swift
//  ErisKeys
//
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

import Foundation
import Ed25519
import RipeMD

open class ErisKey {
  let priv: [UInt8]
  let pub: [UInt8]
  let acct: String
  
  public init(seed: [UInt8])
  {
    
    (pub, priv) = GenerateKey(seed)
    // The calculation of the account address from the public key encodes a type and a length (for backkwards compatibility).
    // Since the length of the public key is now fixed (to 32) and there is a single type encoded as 1, the added bytes are [0x1,0x1,0x20]
    // for all public addresses. See https://github.com/eris-ltd/eris-keys/blob/master/Godeps/_workspace/src/github.com/eris-ltd/tendermint/account/pub_key.go
    // for more details.
    acct = RIPEMD.digest(Data(bytes: [0x01,0x01,0x20] + pub, count: 35)).toHexString()!.uppercased()
  }
  
  open func pubKey() -> [UInt8] {
    return pub
  }

  open func account() -> String {
    return acct
  }
  
  open func sign(_ message: [UInt8]) -> [UInt8] {
    return Sign(priv, message)
  }
  
}

extension Sequence where Iterator.Element == UInt8 {
  public func toString() -> String {
    var s = ""
    _ = self.map({s += String(format: "%02X",$0)})
    return s
  }
}
