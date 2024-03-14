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
            url: "https://github.com/unotag/unomok-sdk-ios/releases/download/1.0.8/Unomok.xcframework.zip", 
            checksum: "216bed0bcd927b0bcc1cee95960a91d72ec281ed5eebff668d6dd740ddac3b56"
        ),
    ]
)
