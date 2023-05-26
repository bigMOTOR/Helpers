// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Helpers",
    platforms: [
        .iOS(.v13),
        .watchOS(.v7),
        .macOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        // MARK: Base
        .library(
            name: "Helpers",
            targets: ["Helpers"]),
        .library(
            name: "HelpersDate",
            targets: ["HelpersDate"]),
        
        // MARK: Specific
        .library(
            name: "HelpersCombine",
            targets: ["HelpersCombine"]),
        .library(
            name: "HelpersRxSwift",
            targets: ["HelpersRxSwift"]),
        .library(
            name: "HelpersSwiftUI",
            targets: ["HelpersSwiftUI"]),
        .library(
            name: "HelpersIAP",
            targets: ["HelpersIAP"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0" )),
        .package(name: "RevenueCat", url: "https://github.com/RevenueCat/purchases-ios.git", .upToNextMajor(from: "4.17.0" ))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Helpers",
            dependencies: []),
        .target(
            name: "HelpersDate",
            dependencies: [
              "Helpers"
            ]),
        .target(
            name: "HelpersCombine",
            dependencies: []),
        .target(
            name: "HelpersRxSwift",
            dependencies: [
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
            ]),
        .target(
            name: "HelpersSwiftUI",
            dependencies: [
              "Helpers"
            ]),
        .target(
            name: "HelpersIAP",
            dependencies: [
              "RevenueCat",
            ])
    ]
)
