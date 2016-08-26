import PackageDescription

let package = Package(
  name: "ErisKeys",
  dependencies: [
    .Package(url: "https://gitlab.com/katalysis/Ed25519", majorVersion: 0, minor: 0),
    .Package(url: "https://gitlab.com/katalysis/RipeMD", majorVersion: 0, minor: 0),
    ]
)
