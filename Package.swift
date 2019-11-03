// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Telesign",
    platforms: [
       .macOS(.v10_14)
    ],
    products: [
        .library(name: "Telesign", targets: ["Telesign"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta"),
        .package(url: "https://github.com/vapor-community/telesignkit.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Telesign", dependencies: ["Vapor", "TelesignKit"]),
        .testTarget(name: "TelesignTests", dependencies: ["Vapor", "Telesign"])
    ]
)
