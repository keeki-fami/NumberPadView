// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalculatorView",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(name: "Calculator", targets: ["Calculator"])
    ],
    targets: [
        .target(name: "Calculator")
    ],
    swiftLanguageModes: [.v6]
    
)
