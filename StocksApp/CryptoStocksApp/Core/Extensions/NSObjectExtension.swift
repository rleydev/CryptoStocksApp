//
//  NSObjectExtension.swift
//  StocksApp
//
//  Created by Arthur Lee on 28.05.2022.
//

import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
