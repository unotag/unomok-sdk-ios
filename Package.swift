// swift-tools-version:5.7

//
//  Package.swift
//  MokSDKExample
//
//  Created by Bindu R S on 16/02/24.
//  Copyright © 2024 Unomok Limited. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "Unomok",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "Unomok", targets: ["Unomok"]),
    ],
    targets: [
        .binaryTarget(
            name: "Unomok",
            url: "https://github.com/unotag/unomok-sdk-ios/releases/download/1.0.7/Unomok.xcframework.zip", 
            checksum: "ecede7526c9c17bf61de7687ba083c89a6b6f12e1a7c545b54ac3abc5b895091"
        ),
    ]
)
