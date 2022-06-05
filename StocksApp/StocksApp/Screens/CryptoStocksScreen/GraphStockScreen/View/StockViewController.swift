//
//  StockViewController.swift
//  StocksApp
//
//  Created by Arthur Lee on 27.05.2022.
//

import UIKit

final class StockViewController: UIViewController {
    
    private var favouriteAction: (() -> Void)?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var graphContainerView: GraphContainerView = {
        let view = GraphContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
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
    
    private lazy var buyStockButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 12)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(buyStockButtonTapped), for: .touchUpInside)
        return button
    }()

    
    override var hidesBottomBarWhenPushed: Bool {
        get { true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }
    
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
        presenter.loadView()
        setupFavoriteButton()
        configureLabelViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func configureLabelViews() {
        titleLabel.text = presenter.symbol
        subtitleLabel.text = presenter.title
        currentPriceLabel.text = presenter.currentPrice
        pricePercentageLabel.text = presenter.priceChange
        pricePercentageLabel.textColor = { presenter.changeColor }()
        buyStockButton.setTitle(presenter.titleForBuyButton, for: .normal)
    }
    
    @objc private func buyStockButtonTapped() {
        let alert = UIAlertController(title: "Buy cryptocurrency", message: "By means of approval the operation you won't be able to cancel it!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Buy", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupFavoriteButton() {
        let button = UIButton()
        button.isSelected = presenter.favoriteButtonIsSelected
        button.setImage(UIImage(named: "starOffNavBar"), for: .normal)
        button.setImage(UIImage(named: "starOn"), for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc private func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        presenter.favoriteButtonTapped() 
    }
    
    private func setupViews() {
        view.addSubview(currentPriceLabel)
        view.addSubview(pricePercentageLabel)
        setUpStackView()
        view.addSubview(stackView)
        navigationItem.titleView = stackView
        view.addSubview(graphContainerView)
        view.addSubview(buyStockButton)
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
        
        /// GraphView
        graphContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        graphContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        graphContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        
        /// Buy Stock Button
        buyStockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        buyStockButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        buyStockButton.topAnchor.constraint(equalTo: graphContainerView.bottomAnchor, constant: 75).isActive = true
        buyStockButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
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

extension StockViewController: StockViewProtocol {
    func updateView(with graphModel: GraphModel) {
        graphContainerView.configureGraph(with: graphModel)
    }

    
    func updateView(withLoader isLoading: Bool) {
        graphContainerView.configure(with: isLoading)
    }
    
    func updateView(withError message: String) {
        
    }
    
    
}



