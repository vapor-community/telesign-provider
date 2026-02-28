// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Telesign",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "Telesign", targets: ["Telesign"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        .package(url: "https://github.com/vapor-community/telesignkit.git", from: "3.2.0-beta"),
    ],
    targets: [
        .target(name: "Telesign",
            dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "TelesignKit", package: "TelesignKit")
            ]),
        .testTarget(name: "TelesignTests",
         dependencies: [
            .product(name: "Vapor", package: "vapor"), "Telesign"])
    ]
)
