//
//  ViewController.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 05/06/2024.
//

import UIKit
import CoreLocation
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    
    let locationManager = CLLocationManager()
    let viewModel = ViewModel(networkManager: NetworkManager())
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTF.delegate = self
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        performSearch()
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func moreDetailButtonTapped(_ sender: UIButton) {
//        performSearch()
    }
    

    func performSearch() {
        guard let cityName = searchTF.text else { return }
//        weatherManager.fetchWeather(cityName: cityName)
        searchTF.endEditing(true)
        
    }

}

