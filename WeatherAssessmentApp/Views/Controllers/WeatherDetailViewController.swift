//
//  WeatherDetailViewController.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var selectedWeatherInfo: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        conditionImageView.image = UIImage(systemName: selectedWeatherInfo?.iconName ?? "")
        tempLabel.text = selectedWeatherInfo?.temp
        cityLabel.text = selectedWeatherInfo?.cityName
        minTempLabel.text = "\(selectedWeatherInfo?.minTemp ?? 0)°C"
        maxTempLabel.text = "\(selectedWeatherInfo?.maxTemp ?? 0)°C"
        humidityLabel.text = "\(selectedWeatherInfo?.humidity ?? 0)"
        descriptionLabel.text = selectedWeatherInfo?.description ?? ""
    }
}
