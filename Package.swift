// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NumberPadView",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(name: "NumberPad", targets: ["NumberPad"])
    ],
    targets: [
        .target(name: "NumberPad")
    ],
    swiftLanguageModes: [.v6]
    
)
