// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Telesign",
    products: [
        .library(name: "Telesign", targets: ["Telesign"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Telesign", dependencies: ["Vapor"]),
        .testTarget(name: "TelesignTests", dependencies: ["Vapor", "Telesign"])
    ]
)
