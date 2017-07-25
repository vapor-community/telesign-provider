import PackageDescription

let package = Package(
    name: "Telesign",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
    ]
)

