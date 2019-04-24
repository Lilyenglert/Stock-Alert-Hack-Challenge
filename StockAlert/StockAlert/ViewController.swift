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

class ViewController: UIViewController {

    var tableView: UITableView!
    var stocks: [Stock]!
    
    let reuseIdentifier = "stockCellReuse"
    let cellHeight: CGFloat = 75
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        let stock1 = Stock(companyName: "Apple", stockTicker: "AAPL", notificationType: .above, notificationPrice: 208, newsSource: .Twitter)
        let stock2 = Stock(companyName: "Facebook", stockTicker: "FB", notificationType: .above, notificationPrice: 208, newsSource: .Twitter)
        let stock3 = Stock(companyName: "Tesla", stockTicker: "TSLA", notificationType: .above, notificationPrice: 208, newsSource: .Twitter)
        let stock4 = Stock(companyName: "Netflix", stockTicker: "NFLX", notificationType: .above, notificationPrice: 208, newsSource: .Twitter)
        let stock5 = Stock(companyName: "Amazon", stockTicker: "AMZN", notificationType: .above, notificationPrice: 208, newsSource: .Twitter)

        stocks = [stock1, stock2, stock3, stock4, stock5]
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StocksTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }


}

extension ViewController: UITableViewDataSource {
    
    /// Tell the table view how many rows should be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    /// Tell the table view what cell to display for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StocksTableViewCell
        let stock = stocks[indexPath.row]
        cell.configure(for: stock)
        cell.selectionStyle = .gray
        
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
