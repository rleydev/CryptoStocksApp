//
//  ExtensionForColor.swift
//  StocksApp
//
//  Created by Arthur Lee on 24.05.2022.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}

extension UIColor {
    enum CustomColors {
        static var changedPriceTextColor = UIColor(r: 36, g: 178, b: 93)
        static var customLightGray = UIColor(r: 240, g: 244, b: 247)
    }
}
