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
    .package(url: "https://gitlab.com/katalysis/open-source/Ed25519.git", from: "0.5.0"),
    .package(url: "https://gitlab.com/katalysis/open-source/RipeMD.git", from: "0.1.5"),
  ],
  targets: [
    .target(name: "ErisKeys", dependencies: ["Ed25519", "RipeMD"]),
    .testTarget(name: "ErisKeysTests", dependencies: ["Ed25519", "RipeMD"]),
  ]
)
