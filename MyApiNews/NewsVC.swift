//
//  NewsVC.swift
//  MyApiNews
//
//  Created by Igor Karyi on 24.12.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsVC: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [String]()
    var descArray = [String]()
    var imgArray = [String]()
    var authorString = [String]()
    
    let url = "https://newsapi.org/v2/top-headlines?sources=bloomberg&apiKey=699bc64e2fe04db2ad782ae344169276"
    
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Загрузка новостей")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.loadNews()

        self.addSlideMenuButton()
    }
    
    @objc func refresh(sender:AnyObject) {
        loadNews()
    }
    
    func loadNews() {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                let json = JSON(data: response.data!)
                if let posts = json["articles"].array {
                    for item in posts {
                        if let title = item["title"].string {
                            print(title)
                            self.titleArray.append(title)
                        }
                        if let desc = item["description"].string {
                            print(desc)
                            self.descArray.append(desc)
                        }
                        if let author = item["source"]["name"].string {
                            print(author)
                            self.authorString.append(author)
                            self.title = author
                        }
                        if let image = item["urlToImage"].string {
                            print(image)
                            self.imgArray.append(image)
                        }
                        if self.titleArray.count > 0 {
                            self.tableView.reloadData()
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = titleArray[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! DetailNewsVC
                destVC.titleText = titleArray[indexPath.row]
                destVC.descText = descArray[indexPath.row]
                destVC.imgView = imgArray[indexPath.row]
            }
        }
    }
    
}
