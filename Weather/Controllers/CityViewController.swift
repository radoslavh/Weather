//
//  CityViewController.swift
//  Weather
//
//  Created by Radoslav Hlinka on 23/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var cityLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getCityTapped(_ sender: Any) {
        //1 Get the city name the user entered in the text field
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
