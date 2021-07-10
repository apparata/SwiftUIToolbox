// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "SwiftUIToolbox",
    platforms: [
        .iOS(.v14), .macOS(.v11), .tvOS(.v14)
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
