//
//  Stock.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 4/23/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import Foundation

enum NotificationType: String {
    case above = "Above"
    case below = "Below"
}

enum NewsSource: String {
    case Twitter = "Twitter"
    case NYT = "The New York Times"
}

class Stock {
    var companyName: String
    var stockTicker: String
    var notificationType: NotificationType
    var notificationPrice: Int
    var newsSource: NewsSource
    
    init(companyName: String, stockTicker: String, notificationType: NotificationType, notificationPrice: Int, newsSource: NewsSource) {
        self.companyName = companyName
        self.stockTicker = stockTicker
        self.notificationType = notificationType
        self.notificationPrice = notificationPrice
        self.newsSource = newsSource
    }
}
