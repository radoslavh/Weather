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

class WeatherController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    
    let locationManager = CLLocationManager()
    var weatherDataMode = WeatherDataModel()
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let nextVC = segue.destination as! CityViewController
            nextVC.listener = self
        }
    }
    
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Sh*t happend!")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            manager.stopUpdatingLocation()
            manager.delegate = nil
            
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
    
    func updateWeatherData(json: JSON){
        if let tempResult = json["main"]["temp"].double {
            weatherDataMode.temperature = Int(tempResult - 273.15)
            weatherDataMode.city = json["name"].stringValue
            weatherDataMode.condition = json["weather"][0]["id"].intValue
            weatherDataMode.weatherConditionIcon = weatherDataMode.updateWeatherIcon(condition: weatherDataMode.condition)
            
            updateUIwithWeatherData()
        } else {
            cityLabel.text = "No data"
        }
    }
    
    func updateUIwithWeatherData() {
        self.temperatureLabel.text = "\(weatherDataMode.temperature)°"
        self.cityLabel.text = "\(weatherDataMode.city)"
        self.weatherImageView.image = UIImage(named: weatherDataMode.weatherConditionIcon)
    }
    
    func onChangeCityAction(cityName: String) {
        let params : [String:String] = ["q" : cityName, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
}

