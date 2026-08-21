// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SlikeRecommendation",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SlikeRecommendation",
            targets: ["SlikeRecommendation"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/AlamofireImage",
            from: "4.0.0"
        ),
    ],
    targets: [
        .target(
            name: "SlikeRecommendation",
            dependencies: [
                .product(name: "AlamofireImage", package: "AlamofireImage"),
            ],
            path: "SlikeRecommendation/Classes"
        ),
    ]
)
