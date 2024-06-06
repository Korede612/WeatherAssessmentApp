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
    
    var viewModel: ViewModelInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveLocationTapped(_ sender: UIButton) {
        guard let location = viewModel?.currentweatherInfo?.cityName,
        let viewModel else { return }
        viewModel.saveCurrentLocation(location: location)
        let alert = UIAlertController(title: "Saving Location", message: "Location Saved Successfully", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func configureView() {
        conditionImageView.image = UIImage(systemName: viewModel?.currentweatherInfo?.iconName ?? "")
        tempLabel.text = viewModel?.currentweatherInfo?.temp
        cityLabel.text = viewModel?.currentweatherInfo?.cityName
        minTempLabel.text = "\(viewModel?.currentweatherInfo?.minTemp ?? 0)°C"
        maxTempLabel.text = "\(viewModel?.currentweatherInfo?.maxTemp ?? 0)°C"
        humidityLabel.text = "\(viewModel?.currentweatherInfo?.humidity ?? 0)"
        descriptionLabel.text = viewModel?.currentweatherInfo?.description ?? ""
    }
}
