//
//  SearchStocksViewController.swift
//  StocksApp
//
//  Created by Arthur Lee on 07.06.2022.
//

import UIKit

final class SearchStocksViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    private lazy var searchViewContainer: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private lazy var titleViewContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var titleOfList: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cancelButton"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "clearButton"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Type cryptocurrency"
        textField.backgroundColor = .white
        textField.returnKeyType = .search
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
        return textField
    }()

    private let colorForOneCell = UIColor(r: 240, g: 244, b: 247)
    
    private var presenter: SearchStocksPresenterProtocol
    
    init(presenter: SearchStocksPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
        setUpSubViews()
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadView()
        
    }
    
    private func setUpTableView() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Search"
    }
    
    private func setUpSubViews() {
        
        view.addSubview(tableView)
        view.addSubview(searchViewContainer)
        
        searchViewContainer.addSubview(cancelButton)
        searchViewContainer.addSubview(clearButton)
        searchViewContainer.addSubview(searchTextField)
        
        view.addSubview(titleViewContainer)
        titleViewContainer.addSubview(titleOfList)
        
        setUpSubViewsConstraints()
    }
    
    private func setUpSubViewsConstraints() {
        
        NSLayoutConstraint.activate([
            
            /// TableView
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: titleViewContainer.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            /// searchContainer
            searchViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            searchViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchViewContainer.heightAnchor.constraint(equalToConstant: 50),
            
            /// titleContainer
            titleViewContainer.topAnchor.constraint(equalTo: searchViewContainer.bottomAnchor),
            titleViewContainer.heightAnchor.constraint(equalToConstant: 30),
            titleViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            /// titleOfList
            titleOfList.leadingAnchor.constraint(equalTo: titleViewContainer.leadingAnchor),
            titleOfList.topAnchor.constraint(equalTo: titleViewContainer.topAnchor, constant: 9),
            
            cancelButton.leadingAnchor.constraint(equalTo: searchViewContainer.leadingAnchor, constant: 16),
            cancelButton.topAnchor.constraint(equalTo: searchViewContainer.topAnchor, constant: 13),
            
            ///clearButton
            clearButton.trailingAnchor.constraint(equalTo: searchViewContainer.trailingAnchor, constant: -16),
            clearButton.topAnchor.constraint(equalTo: searchViewContainer.topAnchor, constant: 13),
            
            ///searchTextField
            searchTextField.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 16),
            searchTextField.topAnchor.constraint(equalTo: searchViewContainer.topAnchor, constant: 13)
        ])
    }
    
    @objc private func clearButtonTapped() {
        searchTextField.text = ""
    }
    
    @objc private func cancelButtonTapped() {
        searchTextField.text = ""
        presenter.loadView()
        tableView.reloadData()
    }
    
    @objc private func textFieldDidChanged(sender: UITextField) {
        presenter.searchStock(searching: sender.text!)
    }
}

extension SearchStocksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else { return UITableViewCell()}
        
        cell.selectionStyle = .none
        if indexPath.row.isMultiple(of: 2) {
            cell.cellView.backgroundColor = colorForOneCell
        } else {
            cell.cellView.backgroundColor = .white
        }
        
        cell.configure(with: presenter.model(for: indexPath))
        
        return cell
    }
}

extension SearchStocksViewController: UITableViewDelegate {
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let model = presenter.model(for: indexPath)
    
            let detailedVC = Assembly.shared.detailedVC(for: model)
            navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension SearchStocksViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        presenter.searchStock(searching: textField.text!)
        return true
    }
}

extension SearchStocksViewController: SearchStocksViewProtocol {
    
    func updateView() {
        tableView.reloadData()
    }
    
    func updateCell(for indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        
    }
}
