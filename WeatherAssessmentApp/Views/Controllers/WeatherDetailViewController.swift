//
//  WeatherDetailViewController.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var selectedWeatherInfo: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
