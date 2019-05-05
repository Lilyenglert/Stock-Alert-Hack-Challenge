//
//  User.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 5/4/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import Foundation

/*struct User: Codable {
    var token: String
}*/


struct Login: Codable {
    //var session_expiration: String?
    //var session_token: String?
    var success: Bool
    //var update_token: String?
    var user: [User]
}

struct Homepage: Codable {
    var success: Bool
    var stocks: [Stocks]
}

struct User: Codable {
    var email: String
    var id: Int
    var stocks: [Stocks]
}

struct Stocks: Codable {
    var company: String
    var id: Int
    var p_change: Float
    //var p_diff: String
    var price: Float
    var ticker: String
}
