// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "R.swift.Plugin",
    products: [
        .library(name: "RSwiftPluginGen", targets: ["RSwiftPluginGen"]),
        .plugin(name: "RSwiftPlugin", targets: ["RSwiftPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.Library", .upToNextMinor(from: "5.3.0"))
    ],
    targets: [
        .binaryTarget(
            name: "rswift",
            path: "Binaries/rswift.artifactbundle"
        ),
        .plugin(
            name: "RSwiftPlugin",
            capability: .buildTool(),
            dependencies: ["rswift"]
        ),
        .target(
            name: "RSwiftPluginGen",
            dependencies: [.product(name: "Rswift", package: "R.swift.Library")],
            plugins: [.plugin(name: "RSwiftPlugin")]
        )
    ]
)
