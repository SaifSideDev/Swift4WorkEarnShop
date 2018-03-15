//
//  CurrencyTextField.swift
//  WorkEarnShop
//
//  Created by Saif Khan on 3/14/18.
//  Copyright © 2018 SaifSide Inc. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTextField: UITextField {
    
    // To See Custom Display Attributes While Working in Storyboard
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        // Customize UITextField Display Attributes
        self.customizeTextField()
        
        // Customize UITextField Placeholder
        self.customizePlaceholder()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Customize UITextField Display Attributes
        self.customizeTextField()
        
        // Customize UITextField Placeholder
        self.customizePlaceholder()
    }
    
    override func draw(_ rect: CGRect) {
        
        // Create and Customize Currency Symbol
        self.createCurrencySymbolIcon()
    }
    
    fileprivate func customizeTextField() {
        // Set UITextField BackgroundColor
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2459140146)
        
        // Set UITextField Corner Radius
        self.layer.cornerRadius = 5.0
        
        // Set UITextField Text Alignment
        self.textAlignment = .center
    }
    
    fileprivate func customizePlaceholder() {
        guard let placeholderString = self.placeholder else { return }
        
        // Set Placeholder Display Attributes
        let customPlaceholder = NSAttributedString(string: placeholderString, attributes: [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        self.attributedPlaceholder = customPlaceholder
        self.textColor = UIColor.white
    }
    
    fileprivate func createCurrencySymbolIcon() {
        let size: CGFloat = 20
        
        // Set Currency Display Attributes
        let currencyLabel = UILabel(frame: CGRect(x: 5, y: (frame.size.height / 2) - size / 2, width: size, height: size))
        currencyLabel.backgroundColor = #colorLiteral(red: 0.6571614146, green: 0.6571771502, blue: 0.6571686864, alpha: 0.8)
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = UIColor.darkGray
        currencyLabel.layer.cornerRadius = 5.0
        currencyLabel.clipsToBounds = true
        
        // Set Currency Symbol
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        currencyLabel.text = formatter.currencySymbol
        
        // Add Currency Symbol Subview to View
        self.addSubview(currencyLabel)
    }
}
