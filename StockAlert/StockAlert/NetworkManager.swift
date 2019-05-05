//
//  NetworkManager.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 5/4/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let endpoint = "http://35.231.31.32/login/"
    private static let searchEndpoint = "http://35.231.31.32/search/Micro"
    private static let homepageEndpoint = "http://35.231.31.32/home/user/"
    private static let addStockEndpoint = "http://35.231.31.32/api/user/"
    
    static func getHomepage(id: Int, completion: @escaping (Homepage) -> Void) {
        let homeEndpoint = homepageEndpoint + String(id) + "/"
        Alamofire.request(homeEndpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let homepageResponse = try? jsonDecoder.decode(Homepage.self, from: data) {
                    completion(homepageResponse)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addStock(id: Int, ticker: String, completion: @escaping (Login) -> Void) {
        let parameters: [String: Any] = [
            "ticker": ticker
        ]
        let addEndpoint = addStockEndpoint + String(id) + "/add/"
        Alamofire.request(addEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).validate().responseData { (response) in
            print(response.request)
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                /*let jsonDecoder = JSONDecoder()
                if let login = try? jsonDecoder.decode(Login.self, from: data) {
                    completion(login)
                } else {
                    print("Invalid Response Data")
                }*/
            case .failure(let error):
                print("Error")
                print(error.localizedDescription)
            }
        }
    }
    
    static func login(email: String, password: String, completion: @escaping (Login) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let login = try? jsonDecoder.decode(Login.self, from: data) {
                    completion(login)
                } else {
                    print("Invalid Response Data")
                }
           case .failure(let error):
                print(error.localizedDescription)
            }
        }
}
}
