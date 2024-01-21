// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftyJSONExt",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_13),
    .tvOS(.v12),
    .watchOS(.v4),
  ],
  products: [
    .library(
      name: "SwiftyJSONExt",
      targets: ["SwiftyJSONExt"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.1"),
  ],
  targets: [
    .target(
      name: "SwiftyJSONExt",
      dependencies: [
        "SwiftyJSON",
      ],
      path: "Sources"
    ),
  ],
  swiftLanguageVersions: [.v5]
)
