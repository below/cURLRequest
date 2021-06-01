// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cURLRequest",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "cURLRequest",
            targets: ["cURLRequest"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "cURLRequest",
            dependencies: []),
        .testTarget(
            name: "cURLRequestTests",
            dependencies: ["cURLRequest"]),
    ]
)
