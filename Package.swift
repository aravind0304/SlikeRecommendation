// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "SlikeRecommendation",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "SlikeRecommendation",
            targets: ["SlikeRecommendation"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/AlamofireImage.git", from: "4.2.0")
    ],
    targets: [
        .target(
            name: "SlikeRecommendation",
            dependencies: ["AlamofireImage"],
            path: "SlikeRecommendation/Classes",
            resources: [
                .process("../SlikeRecResources")
            ]
        )
    ]
)
