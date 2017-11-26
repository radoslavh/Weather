//
//  CityViewController.swift
//  Weather
//
//  Created by Radoslav Hlinka on 23/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func onChangeCityAction(cityName: String)
}

class CityViewController: UIViewController {

    @IBOutlet weak var cityLabel: UITextField!
    
    var listener: ChangeCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getCityTapped(_ sender: Any) {
        let city = cityLabel.text!
        listener?.onChangeCityAction(cityName: city)
        dismiss()
    }
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss()
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
