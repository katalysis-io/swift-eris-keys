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
import Crypto
import RipeMD
import HexString

public enum ErisKeyError : Error {
    case WrongSeedSize
}

extension ErisKeyError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .WrongSeedSize:
            return "WrongSeedSize"
        }
    }
}


public class ErisKey {
    fileprivate let priv: Curve25519.Signing.PrivateKey
    fileprivate let pub: Curve25519.Signing.PublicKey
    fileprivate let acct: String
    
    
    
    public init(_ seed: [UInt8]) throws
    {
        if (seed.count != 32) { throw ErisKeyError.WrongSeedSize }
        priv = try Curve25519.Signing.PrivateKey(rawRepresentation: seed)
        pub = priv.publicKey
        // The calculation of the account address from the public key encodes a type and a length (for backkwards compatibility).
        // Since the length of the public key is now fixed (to 32) and there is a single type encoded as 1, the added bytes are [0x1,0x1,0x20]
        // for all public addresses. See https://github.com/eris-ltd/eris-keys/blob/master/Godeps/_workspace/src/github.com/eris-ltd/tendermint/account/pub_key.go
        // for more details.
        acct = ErisKey.account(pub.rawRepresentation)
    }
    
    public convenience init?(seed: [UInt8]) {
        do {
            try self.init(seed)
        } catch {
            return nil
        }
    }
    
    public var pubKey: [UInt8] {
        get {
            return [UInt8](pub.rawRepresentation)
        }
    }
    
    public var account: String {
        get {
            return acct
        }
    }
    
    public func signAsData<D: DataProtocol>(_ message: D) -> Data {
        return try! priv.signature(for: message)
    }
    
    public func sign<D: DataProtocol>(_ message: D) -> [UInt8] {
        return [UInt8](try! priv.signature(for: message))
    }
    
    public static func verify(_ publicKey: [UInt8], _ dataToSign: [UInt8], _ signature: [UInt8]) -> Bool {
        let initializedSigningPublicKey = try! Curve25519.Signing.PublicKey(rawRepresentation: publicKey)
        
        
        return initializedSigningPublicKey.isValidSignature(signature, for: dataToSign)
    }
    
    public static func account<D: DataProtocol>( _ publicKey: D) -> String {
        return RIPEMD.digest(Data([0x01,0x01,0x20]) + publicKey).toHexString()!.uppercased()
    }
    
    public static func account( _ publicKey: String) -> String {
        if let pub = publicKey.toByteArray() {
            return RIPEMD.digest(Data(bytes: [0x01,0x01,0x20] + pub, count: 35)).toHexString()!.uppercased()
        }
        return ""
    }
}


extension ErisKey {
    public var pubKeyStr: String {
        self.pub.rawRepresentation.reduce("", { $0 + String(format: "%02X",$1)})
    }
    
    public func signAsStr(_ message: [UInt8]) -> String {
        return self.signAsData(message).reduce("", { $0 + String(format: "%02X",$1)})
    }
}
