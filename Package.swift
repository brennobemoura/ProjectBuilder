// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProjectBuilder",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "ProjectBuilder",
            targets: ["ProjectBuilder"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ProjectBuilder",
            dependencies: []
        ),
        .testTarget(
            name: "ProjectBuilderTests",
            dependencies: ["ProjectBuilder"]
        )
    ]
)
