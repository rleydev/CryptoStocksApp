//
//  StockViewController.swift
//  StocksApp
//
//  Created by Arthur Lee on 27.05.2022.
//

import UIKit

class StockViewController: UIViewController {
    
    private let stock: StockGraphModel
    
    private lazy var titleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = stock.symbol.uppercased()
        titleLabel.font = UIFont(name: "Montserrat", size: 18)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = stock.name
        subtitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: "$%.2f", stock.currentPrice)
        label.font = UIFont(name: "Montserrat", size: 28)
        label.frame = CGRect(x: 0, y: 0, width: 98, height: 32)
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        let color = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.textColor = color
        return label
    }()
    
    private lazy var pricePercentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(String(format: "%.2f", stock.changePrice))$ (\(String(format: "%.2f", stock.changePercentage))%)"
        label.font = UIFont(name: "Montserrat", size: 12)
        label.frame = CGRect(x: 0, y: 0, width: 78, height: 16)
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        let color = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
        label.textColor = color
        return label
    }()
    
    private lazy var starButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star") , style: .plain, target: self, action: nil)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = titleStackView
        setupViews()
        setUpConstrains()
        navigationSetup()
    }
    
    init(stock: StockGraphModel) {
        self.stock = stock
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.addSubview(currentPriceLabel)
        view.addSubview(pricePercentageLabel)
        navigationItem.rightBarButtonItem = starButton
        
    }
    
    private func setUpConstrains() {
        
        /// Label 1
        currentPriceLabel.widthAnchor.constraint(equalToConstant: 98).isActive = true
        currentPriceLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        currentPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 2).isActive = true
        currentPriceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 162).isActive = true
        
        /// Label 2
        pricePercentageLabel.widthAnchor.constraint(equalToConstant: 78).isActive = true
        pricePercentageLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        pricePercentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pricePercentageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 202).isActive = true
        
    }
    
    private func navigationSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .black
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

}

