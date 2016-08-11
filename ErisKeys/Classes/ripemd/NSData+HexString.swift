//
//  NSData+HexString.swift
//  ErisKeys
//
//  Created by Alex Tran Qui on 03/06/16.
//
//
//  Inspired by CryptoCoinSwift by Sjors (https://github.com/CryptoCoinSwift/RIPEMD-Swift/ )
//  Inspired by http://stackoverflow.com/questions/26501276/converting-hex-string-to-nsdata-in-swift/26502285
//  Changes copyright © 2016 Katalysis / Alex Tran Qui  (alex.tranqui@gmail.com). All rights reserved.
//

import Foundation

extension Data {
  public func toHexString () -> String? {

    var hexadecimalString = ""
    self.forEach {ui in hexadecimalString += String(format: "%02x", ui)}
    return hexadecimalString
  }
}

extension String {
  
  /// Create NSData from hexadecimal string representation
  ///
  /// This takes a hexadecimal representation and creates a NSData object. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
  ///
  /// The use of `strtoul` inspired by Martin R at [http://stackoverflow.com/a/26284562/1271826](http://stackoverflow.com/a/26284562/1271826)
  ///
  /// - returns: NSData represented by this hexadecimal string.
  
  func toData() -> Data? {
    var data = Data(capacity: characters.count / 2)
    
    let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
    regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, characters.count)) { match, flags, stop in
      let byteString = (self as NSString).substring(with: match!.range)
      let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
      data.append([num], count: 1)
    }
    
    return data
  }

  public func toByteArray() -> Array<UInt8>? {
    //let data = NSMutableData(capacity: characters.count / 2)
    
    var array = [UInt8]()
    let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
    regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, characters.count)) { match, flags, stop in
      let byteString = (self as NSString).substring(with: match!.range)
      let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
      array.append(num)
    }
    return array
  }
}
