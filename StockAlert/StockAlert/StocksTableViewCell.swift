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
    let baseCellColor = UIColor(red: 83/255.0, green: 28/255.0, blue: 221/255.0, alpha: 1.0)
    
    let padding: CGFloat = 15
    let labelHeight: CGFloat = 20
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        self.layer.cornerRadius = 15
        self.backgroundColor = baseCellColor
        self.layer.borderWidth = CGFloat(padding/2.5)
        self.layer.borderColor = UIColor.white.cgColor
        self.selectionStyle = .none
        
        stockTickerLabel = UILabel()
        stockTickerLabel.translatesAutoresizingMaskIntoConstraints = false
        stockTickerLabel.font = UIFont(name:"ArialMT", size: 18)
        stockTickerLabel.textColor = UIColor.white
        contentView.addSubview(stockTickerLabel)
        
        companyNameLabel = UILabel()
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.font = UIFont(name:"ArialMT", size: 10)
        companyNameLabel.textColor = UIColor.white
        companyNameLabel.alpha = 0.75
        contentView.addSubview(companyNameLabel)
        
//        notificationTypeLabel = UILabel()
//        notificationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
//        notificationTypeLabel.font = UIFont(name:"ArialMT", size: 12)
//        contentView.addSubview(notificationTypeLabel)
        
        notificationPriceLabel = UILabel()
        notificationPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationPriceLabel.font = UIFont(name:"ArialMT", size: 12)
        notificationPriceLabel.textColor = UIColor.white
        contentView.addSubview(notificationPriceLabel)
        
        newsSourceLabel = UILabel()
        newsSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSourceLabel.font = UIFont(name:"ArialMT", size: 10)
        newsSourceLabel.textColor = UIColor.white
        newsSourceLabel.alpha = 0.75
        contentView.addSubview(newsSourceLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stockTickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding + 5),
            stockTickerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding + 8),
            stockTickerLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            companyNameLabel.leadingAnchor.constraint(equalTo: stockTickerLabel.leadingAnchor),
            companyNameLabel.topAnchor.constraint(equalTo: stockTickerLabel.bottomAnchor),
            companyNameLabel.heightAnchor.constraint(equalTo: stockTickerLabel.heightAnchor)
            ])
        
//        NSLayoutConstraint.activate([
//            notificationTypeLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
//            notificationTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
//            notificationTypeLabel.heightAnchor.constraint(equalToConstant: labelHeight)
//            ])
        
        NSLayoutConstraint.activate([
            notificationPriceLabel.topAnchor.constraint(equalTo: companyNameLabel.topAnchor),
            notificationPriceLabel.heightAnchor.constraint(equalTo: stockTickerLabel.heightAnchor, constant: -3),
            notificationPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        
        NSLayoutConstraint.activate([
            newsSourceLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor),
            newsSourceLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: -3),
            newsSourceLabel.heightAnchor.constraint(equalTo: companyNameLabel.heightAnchor)
            ])
    }
    
    func configure(for stock: Stock) {
        stockTickerLabel.text = stock.stockTicker
        companyNameLabel.text = stock.companyName
        //notificationTypeLabel.text = stock.notificationType.rawValue
        notificationPriceLabel.text = "WATCHING: "  + String(stock.notificationPrice) + " USD"
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
        super.setSelected(selected, animated: true)

        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted:Bool, animated:Bool){
        super.setHighlighted(false, animated: true)
    }

}
