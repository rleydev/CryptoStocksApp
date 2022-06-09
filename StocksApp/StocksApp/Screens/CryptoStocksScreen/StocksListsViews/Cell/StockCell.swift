//
//  StockCell.swift
//  StocksApp
//
//  Created by Arthur Lee on 24.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {
    
    private var favouriteAction: (() -> Void)?
    
    lazy var cellView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .red
        
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "Apple"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var symbolLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        
        return label
    }()
    
    private lazy var cryptoNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-SemiBold", size: 11)
        
        return label
    }()
    
    lazy var starButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "starOff"), for: .normal)
        button.setImage(UIImage(named: "starOn") , for: .selected)
        button.addTarget(self, action: #selector(starButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        
        return label
    }()
    
    private lazy var changedPriceLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        
        return label
    }()
    
    private let viewContainer: [UIView] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favouriteAction = nil
    }
    
    func configure(with model: StocksModelProtocol) {
        symbolLabel.text = model.symbol
        cryptoNameLabel.text = model.name
        currentPriceLabel.text = model.price
        changedPriceLabel.text = model.priceChanged
        changedPriceLabel.textColor = { model.changeColor }()
        starButton.isSelected = model.isFavorite
        favouriteAction = {
            model.setFavourite()
        }
        iconView.setImage(from: model.iconURL, placeholder: UIImage(named: "questionmark.square.dashed"))
    }
    
    @objc func starButtonPressed(sender: UIButton) {
        sender.isSelected.toggle()
        favouriteAction?()
    }
    
    private func setUpViews() {
        
        contentView.addSubview(cellView)
        
        let cellSubViews = [iconView, symbolLabel, cryptoNameLabel, starButton, currentPriceLabel, changedPriceLabel]
        cellSubViews.forEach { subView in
            cellView.addSubview(subView)
        }
    }
    
    private func setUpConstrains() {

         NSLayoutConstraint.activate([
             // CellView For spacing settings
             cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
             cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
             cellView.heightAnchor.constraint(equalToConstant: 68),
             // Logo
             iconView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
             iconView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
             iconView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8),
             iconView.heightAnchor.constraint(equalToConstant: 52),
             iconView.widthAnchor.constraint(equalToConstant: 52),
             // SymbLabel
             symbolLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
             symbolLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 14),
             // CorporationName label
             cryptoNameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
             cryptoNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -14),
             // StarButton
             starButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6),
             starButton.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16),
             starButton.widthAnchor.constraint(equalToConstant: 16),
             starButton.heightAnchor.constraint(equalToConstant: 16),
             //Current Price Label
             currentPriceLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 14),
             currentPriceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -17),
             //ChagedPrice Label
             changedPriceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
             changedPriceLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -14)
         ])
     }
}
