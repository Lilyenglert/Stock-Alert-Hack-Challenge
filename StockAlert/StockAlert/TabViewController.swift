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

        // Do any additional setup after loading the view.
        
        title = "STOCK ALERT"
        
        let addStockViewController = AddStockViewController()
        
        addStockViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let homeViewController = ViewController(user: user)
        
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let newsViewController = NewsViewController()
        
        newsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        let tabBarList = [homeViewController, addStockViewController, newsViewController]
        
        
        
        viewControllers = tabBarList
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
