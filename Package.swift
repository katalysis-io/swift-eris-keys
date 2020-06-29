// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "ErisKeys",
  platforms: [
      .macOS(.v10_15),
      .iOS(.v13),
      .watchOS(.v6),
      .tvOS(.v13),
 ],
  products: [
    .library(name: "ErisKeys", targets: ["ErisKeys"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-crypto.git", from: "1.0.0"),
    .package(name: "RipeMD", url: "https://github.com/katalysis-io/swift-ripemd.git", .upToNextMinor(from: "0.4.0")),
    .package(name: "HexString", url: "https://github.com/katalysis-io/swift-hex-string.git", from: "0.4.0"),
  ],
  targets: [
    .target(name: "ErisKeys", dependencies: [.product(name: "Crypto", package: "swift-crypto"), "RipeMD", "HexString"]),
    .testTarget(name: "ErisKeysTests", dependencies: ["ErisKeys"]),
  ]
)
