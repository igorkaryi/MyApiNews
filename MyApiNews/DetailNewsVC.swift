//
//  DetailNewsVC.swift
//  MyApiNews
//
//  Created by Igor Karyi on 24.12.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit

class DetailNewsVC: UIViewController {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descNews: UITextView!
    
    var titleText: String?
    var descText: String?
    var imgView: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let titleText = titleText {
            titleNews.text = titleText
        }
        if let descText = descText {
            descNews.text = descText
        }
        if let imgView = imgView {
            imageNews.downloadImage(from: imgView)
        }
    }
    
}
