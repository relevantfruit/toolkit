// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Toolkit",
  platforms: [
    .macOS(.v10_12),
    .iOS(.v12), .tvOS(.v10), .watchOS(.v3)
  ],
  products: [
    .library(name: "Toolkit", targets: ["Toolkit"]),
    .library(name: "ToolkitRxSwift", type: .dynamic, targets: ["ToolkitRxSwift"])
  ],
  dependencies: [
    .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
    .package(url: "https://github.com/airbnb/lottie-ios", from: "3.1.5"),
    .package(url: "https://github.com/devicekit/DeviceKit", from: "2.3.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "19.0.0"),
    .package(url: "https://github.com/bizz84/SwiftyStoreKit", from: "0.15.0"),
    .package(url: "https://github.com/marmelroy/Localize-Swift", from: "3.1.0"),
    .package(url: "https://github.com/huri000/SwiftEntryKit", from: "1.2.3"),
    .package(url: "https://github.com/sunshinejr/Moya-ModelMapper", .branch("master")),
    .package(url: "https://github.com/AliSoftware/Reusable", from: "4.1.1")
  ],
  targets: [
    .target(
      name: "Toolkit",
      dependencies: ["SnapKit", "Lottie", "DeviceKit", "KeychainSwift", "SwiftyStoreKit", "Localize_Swift", "SwiftEntryKit", "Reusable"], path: "Sources", exclude: ["RxSwift"]),
    .target(
      name: "ToolkitRxSwift",
      dependencies: ["Toolkit", "RxMoya-ModelMapper"], path: "Sources", sources: ["RxSwift"])
  ],
  swiftLanguageVersions: [.v5]
)
