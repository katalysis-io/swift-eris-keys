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
    .package(url: "https://gitlab.com/katalysis/open-source/RipeMD.git", .upToNextMinor(from: "0.2.0")),
  ],
  targets: [
    .target(name: "ErisKeys", dependencies: [.product(name: "Crypto", package: "swift-crypto"), "RipeMD"]),
    .testTarget(name: "ErisKeysTests", dependencies: ["ErisKeys", .product(name: "Crypto", package: "swift-crypto"), "RipeMD"]),
  ]
)
