//
//  Extensions.swift
//  MokSDKExample
//
//  Created by Bindu R S on 27/11/23.
//  Copyright © 2023 Unomok Limited. All rights reserved.
//

import UIKit
import SDWebImage

extension UIView {
    //MARK: Set Corner Radius, Border Width, Border Color
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /** setting border for a view */
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /** setting border color for a view */
    @IBInspectable var viewBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UITextField {
    var textCount: Int {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
    }
}

extension UIViewController {
    //MARK: - UIAlertController Methods
    func showAlert(_ vc:UIViewController,title: String, message: String, dismissButtonTitle: String = "OK") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: dismissButtonTitle, style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(dismissAction)
        vc.present(alertController, animated: true)
    }
}

extension String {
    
    func convertToDictionary() -> [String: Any] {
        if let data = data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
            } catch {
                print(error.localizedDescription)
            }
        }
        return [:]
    }
    
    func escapeQuotesExceptFirstAndLast() -> String {
        var escapedString = self
        //            {“name”: “name”, “number”:1}
        escapedString = replacingOccurrences(of: "“", with: "\"")
        escapedString = escapedString.replacingOccurrences(of: "”", with: "\"")
        return escapedString
    }
}
extension String {
    var htmlStringWithViewportMetaTag : String {
        let modifiedHtmlString = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\"></head><body>" + self + "</body></html>"
        return modifiedHtmlString
    }
}

extension UIImageView {
    
    func loadImageView(imageUrlString:String) {
        let url = imageUrlString.replacingOccurrences(of: " ", with: "%20")
        sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        sd_setImage(
            with: URL(string:url)) { [self] _, _, _, _ in
                layoutIfNeeded()
            }
    }
}

