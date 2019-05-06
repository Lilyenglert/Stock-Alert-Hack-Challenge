//
//  NewsViewController.swift
//  StockAlert
//
//  Created by Annamalai Annamalai on 4/26/19.
//  Copyright © 2019 Annamalai Annamalai. All rights reserved.
//

import UIKit
//import TwitterKit

class NewsViewController: UIViewController {

    var newstableView: UITableView!
    //var news: [News] = []
    var tweets: [Tweet] = []
    //var tweetData: [TWTRTweet] = []
    
    let reuseIdentifier = "newsCellReuse"
    let cellHeight: CGFloat = 75
    
    var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        newstableView = UITableView(frame: .zero)
        newstableView.translatesAutoresizingMaskIntoConstraints = false
        newstableView.delegate = self
        newstableView.dataSource = self
        newstableView.backgroundColor = .white
//        newstableView.layer.cornerRadius = 5
        newstableView.register(TwitterTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(newstableView)
        
        setupConstraints()
        //loadNews()
        loadTweets(id: user.id)
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            newstableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newstableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newstableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newstableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    @objc func loadTweets (id: Int) {
        NetworkManager.getTweets(id: id) { tweets in
            if  tweets.success {
                //print(tweets.data.count)
                if tweets.data.count == 0 {
                    let alert = UIAlertController(title: "No Tweets", message: "Unable to load Tweets!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    for tweet in tweets.data {
                        //print(stockPulled.ticker)
                        self.tweets.append(tweet)
                        self.newstableView.reloadData()
                    }
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: "Unable to load Tweets", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    /*func loadNews() {
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
        let params = ["q": "AAPL", "count": "5", "result_type": "popular"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("json: \(json)")
                //TWTRTweet.tweets(withJSONArray: json as! [Any]) as! [TWTRTweet]
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }*/

}

extension NewsViewController: UITableViewDataSource {
    
    /// Tell the table view how many rows should be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !tweets.isEmpty {
            return tweets.count
        } else {
            return 0
        }
    }
    
    /// Tell the table view what cell to display for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TwitterTableViewCell
        let tweetItem = tweets[indexPath.row]
        cell.configure(for: tweetItem)
        cell.selectionStyle = .gray
        
        return cell
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
    /// Tell the table view what height to use for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    /// Tell the table view what should happen if we select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let newsItem = news[indexPath.row]
        //let tweet = tweetData[indexPath.row]
        //let updateViewController = UpdateViewController(stock: stock)
        //updateViewController.delegate = self
        //present(updateViewController, animated: true, completion: nil)
    }
}
