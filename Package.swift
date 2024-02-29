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
            url: "https://github.com/unotag/unomok-sdk-ios/releases/download/1.0.6/Unomok.xcframework.zip", 
            checksum: "f7d297e873d8f1a8f1d5ec025e82b46f8b9ffaccf322608d9f52c2ef2ddc0c12"
        ),
    ]
)
