//
//  AllStocksPresenterTests.swift
//  CryptoStocksAppTests
//
//  Created by Arthur Lee on 09.06.2022.
//

import XCTest
@testable import CryptoStocksApp

class AllStocksPresenterTests: XCTestCase {

    private var presenter: StocksPresenter!
       
       func testItemCount() {
           let empryService = MockStocksServiceEmpty()
           presenter = StocksPresenter(service: empryService)
           presenter.loadView()
           
           XCTAssertEqual(presenter.itemCount, 0, "Количество айтемов не равно 0, хотя мы передавали пустой массив!")
           
           let twoItemService = MockStocksServiceTwoItems()
           presenter = StocksPresenter(service: twoItemService)
           presenter.loadView()
           
           XCTAssertEqual(presenter.itemCount, 2, "Количество айтемов не равно 2, хотя мы передавали массив из двух элементов!")
       }
       
       func testStockModel() {
           let mockService = MockStocksServiceTwoItems()
           presenter = StocksPresenter(service: mockService)
           presenter.loadView()
           
           let model1 = presenter.model(for: IndexPath(row: 0, section: 0).row)
           XCTAssertEqual(model1.id, "stock1", "id модели не совпадает!")
           
           let model2 = presenter.model(for: IndexPath(row: 1, section: 0).row)
           XCTAssertEqual(model2.id, "stock2", "id модели не совпадает!")
       }
   }




class MockStocksServiceEmpty: StocksServiceProtocol {
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Graph, NetworkError>) -> Void) {
        
    }
    
   func getStocks(currency: String, count: String, completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void) {
       completion(.success([]))
   }
}


class MockStocksServiceTwoItems: StocksServiceProtocol {
    
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<Graph, NetworkError>) -> Void) {
        
    }
    
   func getStocks(currency: String, count: String, completion: @escaping (Result<[StocksModelProtocol], NetworkError>) -> Void) {
       let stock1 = Stock(id: "stock1", symbol: "", name: "", image: "", price: 0, change: 0, changePercentage: 0)
       let stock2 = Stock(id: "stock2", symbol: "", name: "", image: "", price: 0, change: 0, changePercentage: 0)

       completion(.success([StockModel(stock: stock1), StockModel(stock: stock2)]))
   }
}
