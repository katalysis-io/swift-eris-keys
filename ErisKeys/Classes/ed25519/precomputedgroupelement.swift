//
//  PrecomputedGroupElement.swift
//  ErisKeys
//
//  Created by Alex Tran Qui on 08/06/16.
//  Port of go implementation of ed25519
//  Copyright © 2016 Katalysis / Alex Tran Qui  (alex.tranqui@gmail.com). All rights reserved.
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
//  Implements the Ed25519 signature algorithm. See
// http://ed25519.cr.yp.to/.

// This code is a port of the public domain, "ref10" implementation of ed25519
// from SUPERCOP.

// Group elements are members of the elliptic curve -x^2 + y^2 = 1 + d * x^2 *
// y^2 where d = -121665/121666.
//
// Several representations are used:
//   ProjectiveGroupElement: (X:Y:Z) satisfying x=X/Z, y=Y/Z
//   ExtendedGroupElement: (X:Y:Z:T) satisfying x=X/Z, y=Y/Z, XY=ZT
//   CompletedGroupElement: ((X:Z),(Y:T)) satisfying x=X/Z, y=Y/T
//   PreComputedGroupElement: (y+x,y-x,2dxy)

struct ProjectiveGroupElement {
  var X: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var Y: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var Z: FieldElement = FieldElement(count: 10, repeatedValue: 0)
}

struct ExtendedGroupElement {
  var X: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var Y: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var Z: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var T: FieldElement = FieldElement(count: 10, repeatedValue: 0)
}

struct CompletedGroupElement {
  var X: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var Y: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var Z: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var T: FieldElement = FieldElement(count: 10, repeatedValue: 0)
}

struct PreComputedGroupElement {
  var yPlusX: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var yMinusX: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var xy2d: FieldElement = FieldElement(count: 10, repeatedValue: 0)
}

struct CachedGroupElement {
  var yPlusX: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var yMinusX: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var Z: FieldElement = FieldElement(count: 10, repeatedValue: 0)
  var T2d: FieldElement = FieldElement(count: 10, repeatedValue: 0)
}


extension ProjectiveGroupElement{
  
  mutating func Zero() {
    FeZero(&(self.X))
    FeOne(&(self.Y))
    FeOne(&self.Z)
  }

  func Double( inout r: CompletedGroupElement) {
    var t0 = FieldElement(count: 10,  repeatedValue: 0)
  
  FeSquare(&r.X, self.X)
  FeSquare(&r.Z, self.Y)
  FeSquare2(&r.T, self.Z)
  FeAdd(&r.Y, self.X, self.Y)
  FeSquare(&t0, r.Y)
  FeAdd(&r.Y, r.Z, r.X)
  FeSub(&r.Z, r.Z, r.X)
  FeSub(&r.X, t0, r.Y)
  FeSub(&r.T, r.T, r.Z)
}

func ToBytes(inout s: [byte]) {
    var recip = FieldElement(count: 10,  repeatedValue: 0)
    var x = FieldElement(count: 10,  repeatedValue: 0)
    var y = FieldElement(count: 10,  repeatedValue: 0)
  
  FeInvert(&recip, self.Z)
  FeMul(&x, self.X, recip)
  FeMul(&y, self.Y, recip)
  FeToBytes(&s, y)
  s[31] ^= FeIsNegative(&x) << 7
}
}

extension ExtendedGroupElement {
mutating func Zero() {
  FeZero(&self.X)
  FeOne(&self.Y)
  FeOne(&self.Z)
  FeZero(&self.T)
}

func Double(inout r: CompletedGroupElement) {
  var q = ProjectiveGroupElement()
  self.ToProjective(&q)
  q.Double(&r)
}

func ToCached(inout r: CachedGroupElement) {
  FeAdd(&r.yPlusX, self.Y, self.X)
  FeSub(&r.yMinusX, self.Y, self.X)
  FeCopy(&r.Z, self.Z)
  FeMul(&r.T2d, self.T, d2)
}

func ToProjective(inout r: ProjectiveGroupElement) {
  FeCopy(&r.X, self.X)
  FeCopy(&r.Y, self.Y)
  FeCopy(&r.Z, self.Z)
}

func ToBytes(inout s: [byte]) {
  var recip = FieldElement(count: 10,  repeatedValue: 0)
  var x = FieldElement(count: 10,  repeatedValue: 0)
  var y = FieldElement(count: 10,  repeatedValue: 0)
  
  FeInvert(&recip, self.Z)
  FeMul(&x, self.X, recip)
  FeMul(&y, self.Y, recip)
  FeToBytes(&s, y)
  s[31] ^= FeIsNegative(&x) << 7
}

mutating func FromBytes(s: [byte]) -> Bool {
    var u = FieldElement(count: 10,  repeatedValue: 0)
    var v = FieldElement(count: 10,  repeatedValue: 0)
    var v3 = FieldElement(count: 10,  repeatedValue: 0)
    var vxx = FieldElement(count: 10,  repeatedValue: 0)
    var check = FieldElement(count: 10,  repeatedValue: 0)
  
  FeFromBytes(&self.Y, s)
  FeOne(&self.Z)
  FeSquare(&u, self.Y)
  FeMul(&v, u, d)
  FeSub(&u, u, self.Z) // y = y^2-1
  FeAdd(&v, v, self.Z) // v = dy^2+1
  
  FeSquare(&v3, v)
  FeMul(&v3, v3, v) // v3 = v^3
  FeSquare(&self.X, v3)
  FeMul(&self.X, self.X, v)
  FeMul(&self.X, self.X, u) // x = uv^7
  
  fePow22523(&self.X, self.X) // x = (uv^7)^((q-5)/8)
  FeMul(&self.X, self.X, v3)
  FeMul(&self.X, self.X, u) // x = uv^3(uv^7)^((q-5)/8)
  
    var tmpX = [byte](count: 32, repeatedValue: 0)
    var tmp2 = [byte](count: 32, repeatedValue: 0)
    
  FeSquare(&vxx, self.X)
  FeMul(&vxx, vxx, v)
  FeSub(&check, vxx, u) // vx^2-u
  if FeIsNonZero(&check) == 1 {
    FeAdd(&check, vxx, u) // vx^2+u
    if FeIsNonZero(&check) == 1 {
      return false
    }
    FeMul(&self.X, self.X, SqrtM1)
    
    FeToBytes(&tmpX, self.X)
    for i in 0..<32 {
      tmp2[31-i] = tmpX[i]
    }
  }
  
  if FeIsNegative(&self.X) == (s[31] >> 7) {
    FeNeg(&self.X, self.X)
  }
  
  FeMul(&self.T, self.X, self.Y)
  return true
}
}

extension CompletedGroupElement {
  func ToProjective(inout r: ProjectiveGroupElement) {
  FeMul(&r.X, self.X, self.T)
  FeMul(&r.Y, self.Y, self.Z)
  FeMul(&r.Z, self.Z, self.T)
}

  func ToExtended(inout r: ExtendedGroupElement) {
  FeMul(&r.X, self.X, self.T)
  FeMul(&r.Y, self.Y, self.Z)
  FeMul(&r.Z, self.Z, self.T)
  FeMul(&r.T, self.X, self.Y)
}

}

extension PreComputedGroupElement {
  
mutating func Zero() {
  FeOne(&self.yPlusX)
  FeOne(&self.yMinusX)
  FeZero(&self.xy2d)
}
}