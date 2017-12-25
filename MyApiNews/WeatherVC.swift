//
//  WeatherVC.swift
//  MyApiNews
//
//  Created by Igor Karyi on 24.12.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherVC: BaseViewController {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var skyImage: UIImageView!
    
    let urlKiev = "http://api.apixu.com/v1/current.json?key=577b3ad23db04a12bfb230854171811&q=Kiev"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSlideMenuButton()
        self.loadWeather()
    }
    
    func loadWeather() {
        Alamofire.request(urlKiev, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let json = JSON(data: response.data!)
                    
                    let country = json["location"]["country"].string
                    let city = json["location"]["name"].string
                    let temperature = json["current"]["temp_c"].int
                    let image = json["current"]["condition"]["icon"].string
                    
                    print(country!)
                    print(city!)
                    print(temperature!)
                    print(image!)
                    
                    self.countryLabel.text = country!
                    self.cityLabel.text = city!
                    self.temperatureLabel.text = "\(temperature!), °C"
                    self.skyImage.downloadImage(from: "http:\(image!)")
                    
                }
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                }
        }
    }

}
