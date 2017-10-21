// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "ErisKeys",
  products: [
    .library(name: "ErisKeys", targets: ["ErisKeys"])
    ],
  dependencies: [
    .package(url: "https://gitlab.com/katalysis/Ed25519.git", .branch("swift-4")),
    .package(url: "https://gitlab.com/katalysis/RipeMD.git", from: "0.1.0"),
    ],
  targets: [
    .target(name: "ErisKeys", dependencies: ["Ed25519", "RipeMD"], path: ".", sources: ["Sources"]),
    ]

)
