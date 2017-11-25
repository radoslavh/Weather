//
//  WeatherController.swift
//  Weather
//
//  Created by Radoslav Hlinka on 23/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherController: UIViewController, CLLocationManagerDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            print(response)
            response.
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            manager.stopUpdatingLocation()
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String:String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable. 😢"
    }
}

