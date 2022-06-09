//
//  NetworkError.swift
//  StocksApp
//
//  Created by Arthur Lee on 26.05.2022.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL = "no URL"
    case missingRequest = "No Request"
    case taskError = "Task error"
    case responseError = "response Error"
    case dataError = "data error"
    case decodeError = "decode error"
}
