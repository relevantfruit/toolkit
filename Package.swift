// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let rxDependencies: [Package.Dependency] = [
  .package(url: "https://github.com/rxswiftcommunity/rxflow", from: "2.9.0"),
  .package(url: "https://github.com/sunshinejr/Moya-ModelMapper", from: "10.0.0"),
  .package(url: "https://github.com/RxSwiftCommunity/RxRealm", from: "3.1.0"),
  .package(url: "https://github.com/RxSwiftCommunity/RxGesture", from: "3.0.3")
]

let package = Package(
  name: "Toolkit",
  platforms: [
    .iOS(.v12),
    .tvOS(.v10),
    .watchOS(.v3)
  ],
  products: [
    .library(name: "Toolkit", targets: ["Toolkit"]),
    .library(name: "ToolkitRxSwift", type: .dynamic, targets: ["ToolkitRxSwift"])
  ],
  dependencies: [
    .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
    .package(url: "https://github.com/airbnb/lottie-ios", from: "3.1.8"),
    .package(url: "https://github.com/devicekit/DeviceKit", from: "3.2.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "19.0.0"),
    .package(url: "https://github.com/bizz84/SwiftyStoreKit", from: "0.16.1"),
    .package(url: "https://github.com/marmelroy/Localize-Swift", from: "3.1.0"),
    .package(url: "https://github.com/AliSoftware/Reusable", from: "4.1.1")
  ] + rxDependencies,
  targets: [
    .target(
      name: "Toolkit",
      dependencies: [
        "SnapKit",
        "Lottie",
        "DeviceKit",
        "KeychainSwift",
        "SwiftyStoreKit",
        "Localize_Swift",
        "Reusable"
      ],
      path: "Sources",
      exclude: ["RxSwift"]),
    .target(
      name: "ToolkitRxSwift",
      dependencies: ["Toolkit", "RxMoya-ModelMapper", "RxFlow", "RxRealm", "RxGesture"],
      path: "Sources",
      sources: ["RxSwift"])
  ],
  swiftLanguageVersions: [.v5]
)
