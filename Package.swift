// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "SwiftUIToolbox",
    platforms: [
        .iOS(.v16), .macOS(.v14), .tvOS(.v16), .visionOS(.v1)
    ],
    products: [
        .library(name: "SwiftUIToolbox", targets: ["SwiftUIToolbox"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUIToolbox",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ]),
        .testTarget(name: "SwiftUIToolboxTests", dependencies: ["SwiftUIToolbox"]),
    ]
)
