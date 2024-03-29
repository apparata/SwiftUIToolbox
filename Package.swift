// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "SwiftUIToolbox",
    platforms: [
        .iOS(.v15), .macOS(.v13), .tvOS(.v15)
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
