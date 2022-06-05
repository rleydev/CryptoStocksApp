//
//  StocksViewController.swift
//  StocksApp
//
//  Created by Arthur Lee on 24.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {
    
    private var presenter: StocksPresenterProtocol
    
    init(presenter: StocksPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        tableView.separatorStyle = .none
        return tableView
    }()

    private let colorForOneCell = UIColor(r: 240, g: 244, b: 247)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableViewView()
        setUpSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadView()
    }
    
    private func setUpTableViewView() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Crypto Stocks"
    }

    private func setUpSubViews() {
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
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

extension StocksViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let model = presenter.model(for: indexPath)
    
            let detailedVC = Assembly.shared.detailedVC(for: model)
            navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension Notification {
    var stockID: String? {
        guard let userInfo = userInfo, let id = userInfo["id"] as? String else { return nil }
        return id
    }
}

extension StocksViewController: StocksViewProtocol {
    
    func updateView() {
        tableView.reloadData()
    }
    
    func updateCell(for indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is -", isLoading, "at -", Date())
    }
    
    func updateView(withError message: String) {
        print("Error -", message)
    }
    
}

