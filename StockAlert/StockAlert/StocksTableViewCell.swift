//
//  StocksTableViewCell.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 4/23/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import UIKit

class StocksTableViewCell: UITableViewCell {
    
    var companyNameLabel: UILabel!
    var stockTickerLabel: UILabel!
    var notificationTypeLabel: UILabel!
    var notificationPriceLabel: UILabel!
    var newsSourceLabel: UILabel!
    
    let padding: CGFloat = 10
    let labelHeight: CGFloat = 20
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stockTickerLabel = UILabel()
        stockTickerLabel.translatesAutoresizingMaskIntoConstraints = false
        stockTickerLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(stockTickerLabel)
        
        companyNameLabel = UILabel()
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(companyNameLabel)
        
        notificationTypeLabel = UILabel()
        notificationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationTypeLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(notificationTypeLabel)
        
        notificationPriceLabel = UILabel()
        notificationPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationPriceLabel.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(notificationPriceLabel)
        
        newsSourceLabel = UILabel()
        newsSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSourceLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(newsSourceLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stockTickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stockTickerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stockTickerLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            companyNameLabel.leadingAnchor.constraint(equalTo: stockTickerLabel.leadingAnchor),
            companyNameLabel.topAnchor.constraint(equalTo: stockTickerLabel.bottomAnchor),
            companyNameLabel.heightAnchor.constraint(equalTo: stockTickerLabel.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            notificationTypeLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding * -20),
            notificationTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            notificationTypeLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            notificationPriceLabel.leadingAnchor.constraint(equalTo: notificationTypeLabel.leadingAnchor),
            notificationPriceLabel.topAnchor.constraint(equalTo: notificationTypeLabel.bottomAnchor),
            notificationPriceLabel.heightAnchor.constraint(equalTo: notificationTypeLabel.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            newsSourceLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor),
            newsSourceLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor),
            newsSourceLabel.heightAnchor.constraint(equalTo: companyNameLabel.heightAnchor)
            ])
    }
    
    func configure(for stock: Stock) {
        stockTickerLabel.text = "Stock Ticker: " + stock.stockTicker
        companyNameLabel.text = "Company: " + stock.companyName
        //notificationTypeLabel.text = stock.notificationType.rawValue
        notificationPriceLabel.text = "Alert Triggered " + stock.notificationType.rawValue + " "  + String(stock.notificationPrice) + " USD"
        newsSourceLabel.text = "News Source: " + stock.newsSource.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
