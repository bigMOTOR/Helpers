// swift-tools-version:5.7
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
        .createLibrary(scope: .base),
        
        // MARK: Specific
        .createLibrary(scope: .date),
        .createLibrary(scope: .combine),
        .createLibrary(scope: .rxSwift),
        .createLibrary(scope: .swiftUI),
        .createLibrary(scope: .iap)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0" )),
        .package(url: "https://github.com/RevenueCat/purchases-ios.git", .upToNextMajor(from: "4.17.0" )),
        .package(url: "https://github.com/realm/SwiftLint", .upToNextMajor(from: "0.52.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .create(scope: .base),
        .create(scope: .date, dependencies: [.init(.base)]),
        .create(scope: .combine),
        .create(scope: .rxSwift, dependencies: ["RxSwift", .product(name: "RxCocoa", package: "RxSwift")]),
        .create(scope: .swiftUI, dependencies: [.init(.base)]),
        .create(scope: .iap, dependencies: [.product(name: "RevenueCat", package: "purchases-ios")])
    ]
)

private enum HelperScope: String {
  case base = "Helpers"
  case date = "HelpersDate"
  case combine = "HelpersCombine"
  case rxSwift = "HelpersRxSwift"
  case swiftUI = "HelpersSwiftUI"
  case iap = "HelpersIAP"
}

private extension PackageDescription.Product {
  static func createLibrary(scope: HelperScope) -> PackageDescription.Product {
    return .library(name: scope.rawValue, targets: [scope.rawValue])
  }
}

private extension Target {
  static func create(scope: HelperScope, dependencies: [Target.Dependency] = []) -> Target {
    return .target(
      name: scope.rawValue,
      dependencies: dependencies,
      plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
    )
  }
}

private extension Target.Dependency {
  init(_ helper: HelperScope) {
    self = .init(stringLiteral: helper.rawValue)
  }
}
