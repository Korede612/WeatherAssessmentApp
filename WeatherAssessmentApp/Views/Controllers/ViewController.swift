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
    
    @IBOutlet weak var savedLocationsView: UIView!
    @IBOutlet weak var savedLocationTitleLabel: UILabel!
    @IBOutlet weak var savedlocationTableView: UITableView!
    
    @IBOutlet weak var seeMoreWeatherInfo: UIButton!
    
    var currentweatherInfo: WeatherModel?
    
    let locationManager = CLLocationManager()
    let viewModel = ViewModel(networkManager: NetworkManager())
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        seeMoreWeatherInfo.isHidden = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        tempLabel.text = "- -"
        cityLabel.text = "- -"
        conditionImageView.image = UIImage(systemName: "questionmark.circle")
        
        searchTF.delegate = self
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        performSearch()
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo" {
            print("Segue is working correctly as expected")
            guard let destinationVC = segue.destination as? WeatherDetailViewController else {
                return
            }
            destinationVC.selectedWeatherInfo = currentweatherInfo
        }
    }
    

    func performSearch() {
        guard let cityName = searchTF.text else { return }
        let fetchWeather: APIEndpoint = .fetchWeatherDataFor(loc: cityName)
        viewModel.networkManager?.request(endpoint: fetchWeather)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: requestCompletionHandler(completion:), receiveValue: requestDataHandler)
            .store(in: &cancellables)
        searchTF.endEditing(true)
        
    }

}

