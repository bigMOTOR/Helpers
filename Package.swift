// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Helpers",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "HelpersCombine",
            targets: ["HelpersCombine"]),
        .library(
            name: "HelpersLibrary",
            targets: ["HelpersLibrary"]),
        .library(
            name: "HelpersRxSwift",
            targets: ["HelpersRxSwift"]),
        .library(
            name: "HelpersTCA",
            targets: ["HelpersTCA"]),
        .library(
            name: "HelpersSwift",
            targets: ["HelpersSwift"]),
        .library(
            name: "HelpersSwiftUI",
            targets: ["HelpersSwiftUI"]),
        .library(
            name: "HelpersIAP",
            targets: ["HelpersIAP"]),
        .library(
            name: "RevenuecatComposable",
            targets: ["RevenuecatComposable"]),
        .library(
            name: "RevenuecatRx",
            targets: ["RevenuecatRx"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0" )),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.19.0" )),
        .package(name: "Purchases", url: "https://github.com/RevenueCat/purchases-ios.git", .upToNextMajor(from: "3.0.0" )),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "HelpersCombine",
            dependencies: []),
        .target(
            name: "HelpersLibrary",
            dependencies: [
                "HelpersSwift"
            ]),
        .target(
            name: "HelpersRxSwift",
            dependencies: [
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
            ]),
        .target(
            name: "HelpersTCA",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
        .target(
            name: "HelpersSwift",
            dependencies: []),
        .target(
            name: "HelpersSwiftUI",
            dependencies: []),
        .target(
            name: "HelpersIAP",
            dependencies: [
              "Purchases",
            ]),
        .target(
            name: "RevenuecatComposable",
            dependencies: [
                "Purchases",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "HelpersIAP",
            ]),
        .target(
            name: "RevenuecatRx",
            dependencies: [
                "Purchases",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                "HelpersIAP",
            ]),
    ]
)


