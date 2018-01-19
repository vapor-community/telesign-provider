// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Telesign",
    products: [
        .library(name: "Telesign", targets: ["Telesign"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .branch("beta"))
    ],
    targets: [
        .target(name: "Telesign", dependencies: ["Vapor"]),
        .testTarget(name: "TelesignTests", dependencies: ["Vapor", "Telesign"])
    ]
)
