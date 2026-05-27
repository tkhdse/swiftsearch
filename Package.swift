// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SwiftSearch",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),  // ← add this
    ],
    targets: [
        .target(name: "Utils", path: "Sources/Utils"),
        .executableTarget(
            name: "Test",
            dependencies: [
                "Utils",
            ],
            path: "Sources/App"
        ),
        .executableTarget(
            name: "Server", 
            dependencies: [
                "Utils",
                .product(name: "Vapor", package: "vapor")
            ], 
            path: "Sources/Server"
        )
    ]
)