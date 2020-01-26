// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-toolkit",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10), .tvOS(.v10), .watchOS(.v3)
    ],
    products: [
        .library(
            name: "ios-toolkit",
            targets: ["ios-toolkit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "3.1.5"),
        .package(url: "https://github.com/devicekit/DeviceKit", from: "2.3.0"),
        .package(url: "https://github.com/evgenyneu/keychain-swift", from: "18.0.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire", from: "5.0.1"),
        .package(url: "https://github.com/bizz84/SwiftyStoreKit", from: "0.15.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "4.9.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "5.0.1"),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "3.5.1"),
        .package(url: "https://github.com/marmelroy/Localize-Swift", from: "3.1.0"),
        .package(url: "https://github.com/huri000/SwiftEntryKit", from: "1.2.3"),
        .package(url: "https://github.com/SwifterSwift/SwifterSwift", from: "5.1.0")
    ],
    targets: [
        .target(
            name: "ios-toolkit",
            dependencies: ["SnapKit", "Lottie", "DeviceKit", "KeychainSwift", "SwiftyStoreKit", "Alamofire", "RxSwift", "ObjectMapper", "Localize_Swift", "SwiftEntryKit", "RxAlamofire", "SwifterSwift"])
    ],
    swiftLanguageVersions: [.v5]
)
