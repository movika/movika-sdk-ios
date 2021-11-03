// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "MovikaSDK",
  platforms: [
    .iOS(.v12)
  ],
  products: [
    .library(
      name: "MovikaSDK",
      targets: ["MovikaSDK"])
  ],
  dependencies: [],
  targets: [
    .binaryTarget(name: "MovikaSDK", path: "MovikaSDK.xcframework")
  ]
)
