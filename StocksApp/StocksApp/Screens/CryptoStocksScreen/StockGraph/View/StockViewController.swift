//
//  StockViewController.swift
//  StocksApp
//
//  Created by Arthur Lee on 27.05.2022.
//

import UIKit

final class StockViewController: UIViewController {
    
    private let stock: StockGraphModel
    
    private lazy var stackView: UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        
        titleLabel.textAlignment = .center
        titleLabel.text = stock.symbol.uppercased()
        titleLabel.font = UIFont(name: "Montserrat", size: 18)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.ColorsForLabels.titleLabel
        
        return titleLabel
    }()
    
    private lazy var subtitleLabel: UILabel = {
        
        let subtitleLabel = UILabel()
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = stock.name
        subtitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor.ColorsForLabels.titleLabel
        
        return subtitleLabel
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: "$%.2f", stock.currentPrice)
        label.font = UIFont(name: "Montserrat", size: 28)
        label.font = .boldSystemFont(ofSize: 28)
        label.minimumScaleFactor = 0.01
        label.textColor = UIColor.ColorsForLabels.titleLabel
        
        return label
    }()
    
    private lazy var pricePercentageLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(String(format: "%.2f", stock.changePrice))$ (\(String(format: "%.2f", stock.changePercentage))%)"
        label.font = UIFont(name: "Montserrat", size: 12)
        label.font = .boldSystemFont(ofSize: 12)
        label.minimumScaleFactor = 0.01
        label.textColor = UIColor.ColorsForLabels.pricePercentageLabel
        
        return label
    }()
    
    private lazy var starButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star") , style: .plain, target: self, action: nil)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        setUpStackView()
        navigationItem.titleView = stackView
        navigationItem.rightBarButtonItem = starButton
    }
    
    private func setUpStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setUpConstrains() {
        
        /// Label 1
        currentPriceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 162).isActive = true
        currentPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        /// Label 2
        pricePercentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pricePercentageLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 8).isActive = true
        
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

