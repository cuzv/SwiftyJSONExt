// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyJSONExt",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_12),
        .tvOS(.v10),
        .watchOS(.v3),
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
            dependencies: ["SwiftyJSON"],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
