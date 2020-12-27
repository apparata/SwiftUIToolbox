// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftUIToolbox",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13)
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
