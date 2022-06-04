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
