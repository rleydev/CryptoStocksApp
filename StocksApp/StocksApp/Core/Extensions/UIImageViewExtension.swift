//
//  UIImageViewExtension.swift
//  StocksApp
//
//  Created by Arthur Lee on 07.06.2022.
//
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(from source: String?, placeholder: UIImage?) {
        guard let urlString = source, let url = URL(string: urlString) else { return }
        
        kf.setImage(with: .network(url), placeholder: placeholder)
    }
}
