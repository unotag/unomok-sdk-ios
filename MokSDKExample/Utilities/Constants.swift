//
//  Constants.swift
//  MokSDKExample
//
//  Created by Bindu R S on 27/11/23.
//  Copyright © 2023 Unomok Limited. All rights reserved.
//

import Foundation
import UIKit

let window = UIApplication
    .shared
    .connectedScenes
    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
    .last

enum MokCarousalContentType : String {
    case image = "image"
    case video = "video"
}

var apnsToken : Data? {
    get {
        return UserDefaults.standard.data(forKey: "apnsTokenData")
    }
    
    set {
        UserDefaults.standard.set(newValue, forKey: "apnsTokenData")
    }
}


