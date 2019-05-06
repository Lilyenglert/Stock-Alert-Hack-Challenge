//
//  ViewController.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 4/23/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import UIKit

protocol StockUpdateDelegate: class {
    func updateStock(stock: Stock)
}

protocol UserLoginDelegate: class {
    func updateUser(user: User)
}

class ViewController: UIViewController {

    var tableView: UITableView!
    var stocks: [Stock] = []
    let reuseIdentifier = "stockCellReuse"
    let cellHeight: CGFloat = 100
    
    var user: User
    
    init(user: User) {
        self.user = user
        print("Creating User")
        print(self.user.id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
        view.backgroundColor = .white
        //let stock1 = Stock(companyName: "Apple", stockTicker: "AAPL", notificationType: .above, notificationPrice: 208, newsSource: .Twitter)

        //stocks = [stock1]
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StocksTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
//        tableView.allowsSelection = false
//        self.tableView.rowHeight = 44.0
        setupConstraints()
        
        print("Before getting homepage")
        print(user.id)
        getHomepage(id: user.id)
        
    }
    
    @objc func getHomepage (id: Int) {
        NetworkManager.getHomepage(id: id) { homepage in
            if  homepage.success {
                print("Got Homepage!")
                print(homepage.stocks.count)
                if homepage.stocks.count == 0 {
                    let alert = UIAlertController(title: "No Stock Tracking Present", message: "Please add new tracking!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    for stockPulled in homepage.stocks {
                        print(stockPulled.ticker)
                        self.stocks.append(Stock(companyName: stockPulled.company, stockTicker: stockPulled.ticker, notificationType: .below, notificationPrice: Int(stockPulled.price), newsSource: .Twitter))
                        self.tableView.reloadData()
                    }
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: "Unable to Refresh", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    func pleaseAddStock(stock: Stock) {
        stocks.append(stock)
    
        NetworkManager.addStock(id: user.id, ticker: stock.stockTicker) { login in
            if  login.success {
                print("Adding Stock!")
            } else {
                let alert = UIAlertController(title: "Alert", message: "Unable to Add Stock!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        tableView.reloadData()
    }

    
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }


}

extension ViewController: UITableViewDataSource {
    
    /// Tell the table view how many rows should be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if !stocks.isEmpty {
            return stocks.count
        } else {
            return 0
        }
    }
    
    /// Tell the table view what cell to display for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StocksTableViewCell
        let stock = stocks[indexPath.row]
        cell.configure(for: stock)
        cell.selectionStyle = .none
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    /// Tell the table view what height to use for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    /// Tell the table view what should happen if we select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! StocksTableViewCell
        let stock = stocks[indexPath.row]
        let updateViewController = UpdateViewController(stock: stock)
        updateViewController.delegate = self
        present(updateViewController, animated: true, completion: nil)
    }
}

extension ViewController: StockUpdateDelegate {
    
    func updateStock(stock: Stock) {
        tableView.reloadData()
    }
}

extension ViewController: UserLoginDelegate {
    
    func updateUser(user: User) {
        //tableView.reloadData()
        print("The Calling!!!!!")
    }
}
