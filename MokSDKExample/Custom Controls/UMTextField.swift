//
//  UMTextField.swift
//  MokSDKExample
//
//  Created by Bindu R S on 27/11/23.
//  Copyright © 2023 Logidots Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class UMTextField: UITextField {
    
    let border = CALayer()
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineColor : UIColor = UIColor.black {
        didSet{
            border.backgroundColor = lineColor.cgColor
        }
    }
    
    @IBInspectable open var selectedLineColor : UIColor = UIColor.black {
        didSet{
            border.backgroundColor = selectedLineColor.cgColor
        }
    }
    
    
    @IBInspectable open var lineHeight : CGFloat = CGFloat(1.0) {
        didSet{
            border.frame = CGRect(x: 0, y: frame.size.height - lineHeight, width:  frame.size.width, height: frame.size.height)
        }
    }
    
    required init?(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)
        delegate = self;
        border.borderColor = lineColor.cgColor
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ])
        
        
        border.frame = CGRect(x: 0, y: frame.size.height - lineHeight, width:  frame.size.width, height: lineHeight)
        border.backgroundColor = lineColor.cgColor
        border.borderWidth = lineHeight
        layer.addSublayer(border)
        layer.masksToBounds = true
        clearButtonMode = .whileEditing
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        if let placeholder = self.placeholder, let font = self.font {
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: placeholderColor,
                NSAttributedString.Key.font: font
            ]
            
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            attributedPlaceholder.draw(in: rect)
        } else {
            super.drawPlaceholder(in: rect)
        }
    }
    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: frame.size.height - lineHeight, width:  frame.size.width, height: frame.size.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBorderWithLineHeight(borderHeight: lineHeight, color: lineColor)
        delegate = self
    }
    
    private func updateBorderWithLineHeight(borderHeight: CGFloat, color: UIColor) {
        border.frame = CGRect(x: 0, y: frame.size.height - borderHeight, width:  frame.size.width, height: borderHeight)
        border.borderColor = color.cgColor
    }
}

extension UMTextField : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBorderWithLineHeight(borderHeight: lineHeight*2, color: selectedLineColor)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBorderWithLineHeight(borderHeight: lineHeight, color: lineColor)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
