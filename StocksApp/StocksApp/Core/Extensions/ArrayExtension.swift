//
//  ArrayExtension.swift
//  StocksApp
//
//  Created by Arthur Lee on 08.06.2022.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
