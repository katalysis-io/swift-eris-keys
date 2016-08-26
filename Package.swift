import PackageDescription

let package = Package(
  name: "ErisKeys",
  dependencies: [
    .Package(url: "git@gitlab.com:katalysis/Ed25519.git", majorVersion: 0, minor: 1),
    .Package(url: "git@gitlab.com:katalysis/RipeMD.git", majorVersion: 0, minor: 1),
    ]
)
