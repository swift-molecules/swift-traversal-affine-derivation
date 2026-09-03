// swift-tools-version: 6.4

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "swift-traversal-affine-derivation",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Traversal Affine Derivation", targets: ["Traversal Affine Derivation"]),
        .library(name: "Traversal Affine Derivation Core", targets: ["Traversal Affine Derivation Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-either.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-optic.git", branch: "main"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", "603.0.2"..<"604.0.0"),
    ],
    targets: [
        .target(
            name: "Traversal Affine Derivation Core",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
            ]
        ),
        .macro(
            name: "Traversal Affine Derivation Macros",
            dependencies: [
                "Traversal Affine Derivation Core",
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            ]
        ),
        .target(
            name: "Traversal Affine Derivation",
            dependencies: [
                "Traversal Affine Derivation Macros",
                .product(name: "Optic", package: "swift-optic"),
            ]
        ),
        .testTarget(
            name: "Traversal Affine Derivation Tests",
            dependencies: [
                "Traversal Affine Derivation",
                .product(name: "Either", package: "swift-either"),
                .product(name: "Optic", package: "swift-optic"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
