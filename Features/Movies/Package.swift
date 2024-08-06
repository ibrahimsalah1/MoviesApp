// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Movies",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Movies",
            targets: ["Movies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.1.1"),
        .package(path: "../NetworkLayer"),
        .package(path: "../Domain"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Movies",
            dependencies: [
            "NetworkLayer",
            "Domain",
            .product(name: "DomainData", package: "Domain"),
            .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
        ]),
        .testTarget(
            name: "MoviesTests",
            dependencies: ["Movies"]),
    ]
)

