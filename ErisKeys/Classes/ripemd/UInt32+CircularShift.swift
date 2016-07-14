//
//  UInt32+CircularShift.swift
//  ErisKeys
//
//  Created by Alex Tran Qui on 03/06/16.
//
//
//  Originally taken from CryptoCoinSwift by Sjors (https://github.com/CryptoCoinSwift/RIPEMD-Swift/ )
//  Changes copyright © 2016 Katalysis / Alex Tran Qui  (alex.tranqui@gmail.com). All rights reserved.

import Foundation

// Circular left shift: http://en.wikipedia.org/wiki/Circular_shift
// Precedence should be the same as <<
infix operator  ~<< { precedence 160 associativity none }

internal func ~<< (lhs: UInt32, rhs: Int) -> UInt32 {
  return (lhs << UInt32(rhs)) | (lhs >> UInt32(32 - rhs));
}