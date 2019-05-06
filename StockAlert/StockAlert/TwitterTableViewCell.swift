//
//  TwitterTableViewCell.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 5/5/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {
    var twitterTextView: UITextView!
    var twitterUserLabel: UILabel!
    //var notificationTypeLabel: UILabel!
    //var notificationPriceLabel: UILabel!
    //var newsSourceLabel: UILabel!
    let baseCellColor = UIColor(red: 83/255.0, green: 28/255.0, blue: 221/255.0, alpha: 1.0)
    
    let padding: CGFloat = 5
    let labelHeight: CGFloat = 25
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        self.layer.cornerRadius = 15
        self.backgroundColor = baseCellColor
        self.layer.borderWidth = CGFloat(padding/2.45)
        self.layer.borderColor = UIColor.white.cgColor
        self.selectionStyle = .none
        
        twitterUserLabel = UILabel()
        twitterUserLabel.translatesAutoresizingMaskIntoConstraints = false
        twitterUserLabel.font = UIFont(name:"ArialMT", size: 11)
        twitterUserLabel.textColor = UIColor.white
        contentView.addSubview(twitterUserLabel)
        
        twitterTextView = UITextView()
        twitterTextView.translatesAutoresizingMaskIntoConstraints = false
        twitterTextView.font = UIFont(name:"ArialMT", size: 11)
        twitterTextView.textColor = UIColor.white
        twitterTextView.isScrollEnabled = false
        twitterTextView.backgroundColor = baseCellColor
        twitterTextView.isSelectable = true
        twitterTextView.isEditable = false
        twitterTextView.textAlignment = .left
        twitterTextView.alpha = 0.75
        contentView.addSubview(twitterTextView)
        
        
        
        
        //        notificationTypeLabel = UILabel()
        //        notificationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        //        notificationTypeLabel.font = UIFont(name:"ArialMT", size: 12)
        //        contentView.addSubview(notificationTypeLabel)
        
        /*notificationPriceLabel = UILabel()
        notificationPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationPriceLabel.font = UIFont(name:"ArialMT", size: 12)
        notificationPriceLabel.textColor = UIColor.white
        contentView.addSubview(notificationPriceLabel)*/
        
        /*newsSourceLabel = UILabel()
        newsSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSourceLabel.font = UIFont(name:"ArialMT", size: 10)
        newsSourceLabel.textColor = UIColor.white
        newsSourceLabel.alpha = 0.75
        contentView.addSubview(newsSourceLabel)*/
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            twitterUserLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding + 1),
            twitterUserLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding + 1),
            twitterUserLabel.heightAnchor.constraint(equalToConstant: labelHeight - 9)
            ])
        
        NSLayoutConstraint.activate([
            twitterTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            twitterTextView.topAnchor.constraint(equalTo: twitterUserLabel.bottomAnchor),
            twitterTextView.heightAnchor.constraint(equalToConstant: labelHeight * 1.9),
            twitterTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
            ])
        
        //        NSLayoutConstraint.activate([
        //            notificationTypeLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        //            notificationTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
        //            notificationTypeLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        //            ])
        
        /*NSLayoutConstraint.activate([
            notificationPriceLabel.topAnchor.constraint(equalTo: twitterTextLabel.topAnchor),
            notificationPriceLabel.heightAnchor.constraint(equalTo: twitterUserLabel.heightAnchor, constant: -3),
            notificationPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])*/
        
        /*NSLayoutConstraint.activate([
            newsSourceLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor),
            newsSourceLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: -3),
            newsSourceLabel.heightAnchor.constraint(equalTo: companyNameLabel.heightAnchor)
            ])*/
    }
    
    func configure(for tweet: Tweet) {
        twitterUserLabel.text = tweet.user + ":"
        twitterTextView.text = tweet.text
        //notificationPriceLabel.text = "WATCHING: "  + String(stock.notificationPrice) + " USD"
        //newsSourceLabel.text = "News Source: " + stock.newsSource.rawValue
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
    
    override func setHighlighted(_ highlighted:Bool, animated:Bool){
        super.setHighlighted(false, animated: true)
    }

}
