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
    enum ColorsForLabels {
        static var titleLabel = UIColor(r: 0.1, g: 0.1, b: 0.1)
        static var pricePercentageLabel = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
    }
}

