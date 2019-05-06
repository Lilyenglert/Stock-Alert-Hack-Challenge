//
//  TabViewController.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 4/23/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
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
//        title = "stocks"
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = true
        let imageView = UIImageView(frame: (CGRect(x: 0, y: 0, width: 100, height: 20)))
        imageView.contentMode = .scaleAspectFit
//        self.UINavigationBar.bounds = view.frame.insetBy(dx: 10.0, dy: 10.0)
        let image = UIImage (named: "logStocks")
        imageView.clipsToBounds = true
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationItem.titleView?.contentMode = .scaleAspectFit
        self.navigationItem.titleView?.clipsToBounds = true
//        self.clipsto
        
       
        
        let addStockViewController = AddStockViewController()
        
        addStockViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let homeViewController = ViewController(user: user)
        
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let newsViewController = NewsViewController()
        
        let news = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        
        newsViewController.tabBarItem = news
        
        let tabBarList = [homeViewController, newsViewController, addStockViewController]
        
        
        viewControllers = tabBarList
    }
    
//    func setupConstraints() {
//        // Setup the constraints for our views
//        NSLayoutConstraint.activate([
//            image.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal),
//            image.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .horizontal),
//            image.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical),
//            image.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .vertical)
//    )}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
