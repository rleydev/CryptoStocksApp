//
//  NotificationExtension.swift
//  StocksApp
//
//  Created by Arthur Lee on 08.06.2022.
//

import Foundation

extension Notification {
    var stockID: String? {
        guard let userInfo = userInfo, let id = userInfo["id"] as? String else { return nil }
        return id
    }
}
