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
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 18)
        titleLabel.textColor = .black
        
        return titleLabel
    }()
    
    private lazy var subtitleLabel: UILabel = {
        
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        subtitleLabel.textColor = .black
        
        return subtitleLabel
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 28)
        label.minimumScaleFactor = 0.01
        label.textColor = .black
        
        return label
    }()
    
    private lazy var pricePercentageLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        label.minimumScaleFactor = 0.01
        
        return label
    }()
    
    private lazy var buyStockButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
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
        presenter.loadView()
        setupFavoriteButton()
        configureLabelViews()
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
        
        
        NSLayoutConstraint.activate([
            /// Current Price Label
            currentPriceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 162),
            currentPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            /// PriceChangedLabel
            pricePercentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pricePercentageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 202),
            
            /// GraphView
            graphContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            graphContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            graphContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            
            // Buy Stock Button
            buyStockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buyStockButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buyStockButton.topAnchor.constraint(equalTo: graphContainerView.bottomAnchor, constant: 75),
            buyStockButton.heightAnchor.constraint(equalToConstant: 56)
        ])
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
