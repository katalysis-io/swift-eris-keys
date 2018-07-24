// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "ErisKeys",
  products: [
    .library(name: "ErisKeys", targets: ["ErisKeys"])
    ],
  dependencies: [
    .package(url: "https://gitlab.com/katalysis/open-source/Ed25519.git", from: "0.2.0"),
    .package(url: "https://gitlab.com/katalysis/open-source/RipeMD.git", from: "0.1.0"),
    ],
  targets: [
    .target(name: "ErisKeys", dependencies: ["Ed25519", "RipeMD"], path: ".", sources: ["Sources"]),
    ]
)