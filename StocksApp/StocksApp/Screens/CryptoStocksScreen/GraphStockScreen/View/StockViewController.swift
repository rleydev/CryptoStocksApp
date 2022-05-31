//
//  StockViewController.swift
//  StocksApp
//
//  Created by Arthur Lee on 27.05.2022.
//

import UIKit

final class StockViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Title"
        titleLabel.font = UIFont(name: "Montserrat", size: 18)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        return titleLabel
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Name"
        subtitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        return subtitleLabel
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: "$%.2f", "Price")
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
        label.text = "\(String(format: "%.2f", "Change"))$ (\(String(format: "%.2f", "percentage"))%)"
        label.font = UIFont(name: "Montserrat", size: 12)
        label.frame = CGRect(x: 0, y: 0, width: 78, height: 16)
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        return label
    }()
    
    private lazy var graphView: UIView = {
        let graphView = UIView()
        graphView.translatesAutoresizingMaskIntoConstraints = false
        graphView.backgroundColor = .red
        return graphView
    }()
    
    private lazy var starButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star") , style: .plain, target: self, action: nil)
        return button
        
    }()
    
    var presenter: StockPresentProtocol
    
    init(with presenter: StockPresentProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setUpConstrains()
        navigationSetup()
        
    }
    
    func configureLabelViews(with model: StocksModelProtocol) {
        titleLabel.text = model.symbol
        subtitleLabel.text = model.name
        currentPriceLabel.text = model.price
        pricePercentageLabel.text = model.priceChanged
        pricePercentageLabel.textColor = { model.changeColor }()
        
    }
    
    func configureGraphChart(with graphData: StockPricesModelProtocol) {
        // configure graph from
//        graphData.prices
        
    }
    
    private func setupViews() {
        view.addSubview(currentPriceLabel)
        view.addSubview(pricePercentageLabel)
        view.addSubview(graphView)
        setUpStackView()
        view.addSubview(stackView)
        navigationItem.titleView = stackView
        navigationItem.rightBarButtonItem = starButton
    }
    
    private func setUpStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
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
        /// View
        graphView.topAnchor.constraint(equalTo: view.topAnchor, constant: 248).isActive = true
        graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        graphView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -212).isActive = true
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


