// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "swift-search",
    targets: [
        .target(name: "Utils", path: "Sources/Utils"),
        .executableTarget(name: "swift-search", dependencies: ["Utils"], path: "Sources/App")
    ]
)