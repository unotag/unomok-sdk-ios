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
            url: "https://github.com/unotag/unomok-sdk-ios/releases/download/1.0.3/Unomok.xcframework.zip", 
            checksum: "d186d36b0544637b28a9918e920a0cdfb671853eb4afb55087663e5b054e2628"
        ),
    ]
)
