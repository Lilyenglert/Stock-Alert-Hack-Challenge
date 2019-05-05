//
//  AddStockViewController.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 4/26/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import UIKit

class AddStockViewController: UIViewController {

    var companyNameTextField: UITextField!
    var stockTickerTextField: UITextField!
    var notificationTypeSegmentControl: UISegmentedControl!
    var notificationPriceTextField: UITextField!
    var newsSourcePickerView: UIPickerView!
    var newsSourceTextField: UITextField!
    var addUpdateButton: UIButton!
    
    var companyNameTextView: UITextView!
    var stockTickerTextView: UITextView!
    var notificationTypeTextView: UITextView!
    var notificationPriceTextView: UITextView!
    var newsSourceTextView: UITextView!
    
    var pickOption = ["Twitter", "The New York Times"]
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        companyNameTextView = UITextView()
        companyNameTextView.translatesAutoresizingMaskIntoConstraints = false
        companyNameTextView.text = "Company Name: "
        companyNameTextView.textAlignment = .right
        companyNameTextView.isEditable = false
        companyNameTextView.isScrollEnabled = false
        companyNameTextView.font = UIFont.systemFont(ofSize: 16)
        companyNameTextView.textColor = .black
        view.addSubview(companyNameTextView)
        
        companyNameTextField = UITextField()
        companyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        companyNameTextField.text = ""
        companyNameTextField.textAlignment = .left
        companyNameTextField.font = UIFont.systemFont(ofSize: 16)
        companyNameTextField.textColor = .black
        companyNameTextField.backgroundColor = .lightGray
        view.addSubview(companyNameTextField)
        
        stockTickerTextView = UITextView()
        stockTickerTextView.translatesAutoresizingMaskIntoConstraints = false
        stockTickerTextView.text = "Stock Ticker: "
        stockTickerTextView.textAlignment = .right
        stockTickerTextView.isEditable = false
        stockTickerTextView.isScrollEnabled = false
        stockTickerTextView.font = UIFont.systemFont(ofSize: 16)
        stockTickerTextView.textColor = .black
        view.addSubview(stockTickerTextView)
        
        stockTickerTextField = UITextField()
        stockTickerTextField.translatesAutoresizingMaskIntoConstraints = false
        stockTickerTextField.text = ""
        stockTickerTextField.textAlignment = .left
        stockTickerTextField.font = UIFont.systemFont(ofSize: 16)
        stockTickerTextField.textColor = .black
        stockTickerTextField.backgroundColor = .lightGray
        view.addSubview(stockTickerTextField)
        
        notificationTypeTextView = UITextView()
        notificationTypeTextView.translatesAutoresizingMaskIntoConstraints = false
        notificationTypeTextView.text = "Notification Type: "
        notificationTypeTextView.textAlignment = .right
        notificationTypeTextView.isEditable = false
        notificationTypeTextView.isScrollEnabled = false
        notificationTypeTextView.font = UIFont.systemFont(ofSize: 16)
        notificationTypeTextView.textColor = .black
        view.addSubview(notificationTypeTextView)
        
        let items = ["Above", "Below"]
        notificationTypeSegmentControl = UISegmentedControl(items: items)
        notificationTypeSegmentControl.center = self.view.center
        notificationTypeSegmentControl.selectedSegmentIndex = 0
        notificationTypeSegmentControl.addTarget(self, action: #selector(segmentToggle(_:)), for: .valueChanged)
        notificationTypeSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationTypeSegmentControl)
        
        notificationPriceTextView = UITextView()
        notificationPriceTextView.translatesAutoresizingMaskIntoConstraints = false
        notificationPriceTextView.text = "Notification Price ($): "
        notificationPriceTextView.textAlignment = .right
        notificationPriceTextView.isEditable = false
        notificationPriceTextView.isScrollEnabled = false
        notificationPriceTextView.font = UIFont.systemFont(ofSize: 16)
        notificationPriceTextView.textColor = .black
        view.addSubview(notificationPriceTextView)
        
        notificationPriceTextField = UITextField()
        notificationPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        notificationPriceTextField.text = ""
        notificationPriceTextField.textAlignment = .left
        notificationPriceTextField.font = UIFont.systemFont(ofSize: 16)
        notificationPriceTextField.textColor = .black
        notificationPriceTextField.backgroundColor = .lightGray
        view.addSubview(notificationPriceTextField)
        
        addUpdateButton = UIButton()
        addUpdateButton.translatesAutoresizingMaskIntoConstraints = false
        addUpdateButton.setTitle("Add Tracking", for: .normal)
        addUpdateButton.setTitleColor(.blue, for: .normal)
        addUpdateButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        addUpdateButton.addTarget(self, action: #selector(dismissViewControllerAndUpdateSong), for: .touchUpInside)
        view.addSubview(addUpdateButton)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            companyNameTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            companyNameTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            companyNameTextView.heightAnchor.constraint(equalToConstant: 30),
            companyNameTextView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            companyNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            companyNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            companyNameTextField.heightAnchor.constraint(equalToConstant: 30),
            companyNameTextField.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            stockTickerTextView.topAnchor.constraint(equalTo: companyNameTextView.bottomAnchor, constant: 10),
            stockTickerTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            stockTickerTextView.heightAnchor.constraint(equalToConstant: 30),
            stockTickerTextView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            stockTickerTextField.topAnchor.constraint(equalTo: companyNameTextView.bottomAnchor, constant: 10),
            stockTickerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            stockTickerTextField.heightAnchor.constraint(equalToConstant: 30),
            stockTickerTextField.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            notificationTypeTextView.topAnchor.constraint(equalTo: stockTickerTextView.bottomAnchor, constant: 10),
            notificationTypeTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            notificationTypeTextView.heightAnchor.constraint(equalToConstant: 30),
            notificationTypeTextView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            notificationTypeSegmentControl.topAnchor.constraint(equalTo: stockTickerTextView.bottomAnchor, constant: 10),
            notificationTypeSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            notificationTypeSegmentControl.heightAnchor.constraint(equalToConstant: 30),
            notificationTypeSegmentControl.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            notificationPriceTextView.topAnchor.constraint(equalTo: notificationTypeTextView.bottomAnchor, constant: 10),
            notificationPriceTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            notificationPriceTextView.heightAnchor.constraint(equalToConstant: 30),
            notificationPriceTextView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            notificationPriceTextField.topAnchor.constraint(equalTo: notificationTypeTextView.bottomAnchor, constant: 10),
            notificationPriceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            notificationPriceTextField.heightAnchor.constraint(equalToConstant: 30),
            notificationPriceTextField.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            addUpdateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addUpdateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            addUpdateButton.heightAnchor.constraint(equalToConstant: 25),
            addUpdateButton.widthAnchor.constraint(equalToConstant: 250)
            ])
    }
    
    @objc func segmentToggle(_ sender:UISegmentedControl) {
        /*switch sender.selectedSegmentIndex{
         case 0:
         refreshShoppingListView(item: "", qty: "", type: 0)
         case 1:
         refreshShoppingListView(item: "", qty: "", type: 1)
         default:
         break
         }*/
    }
    
    @objc func dismissViewControllerAndUpdateSong() {
        
        if let companyName = companyNameTextField.text, companyName != "", let stockTicker = stockTickerTextField.text, stockTicker != "", let notificationPrice = notificationPriceTextField.text, notificationPrice != ""  {
            let stock = Stock(companyName: companyName, stockTicker: stockTicker, notificationType: .above, notificationPrice: 0, newsSource: .Twitter)
            if notificationTypeSegmentControl.selectedSegmentIndex == 0 {
                stock.notificationType = .above
            } else {
                stock.notificationType = .below
            }
            stock.notificationPrice = Int(notificationPrice)!
            let controllers = tabBarController?.viewControllers
            let home = controllers![0] as! ViewController
            
            home.pleaseAddStock(stock: stock)
            tabBarController?.selectedIndex = 0
        } else {
            let alert = UIAlertController(title: "Error", message: "Check Entered Values", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

}
