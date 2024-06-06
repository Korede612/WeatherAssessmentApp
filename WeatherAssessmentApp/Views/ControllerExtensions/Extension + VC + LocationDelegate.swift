//
//  Extension + VC + LocationDelegate.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import CoreLocation
import Combine
import UIKit

//MARK: - CoreLocation Delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else {
            return
        }
        locationManager.stopUpdatingLocation()
        let lat = Float(userLocation.coordinate.latitude)
        let lon = Float(userLocation.coordinate.longitude)
        
        let fetchWeather: APIEndpoint = .fetchWeatherDataUsing(lat: "\(lat)", lon: "\(lon)")
        viewModel.networkManager?.request(endpoint: fetchWeather)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: requestCompletionHandler(completion:), receiveValue: requestDataHandler)
            .store(in: &cancellables)
    }
    
    func requestCompletionHandler(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("Completed")
        case .failure(let error):
            print("An error occured: \(error.localizedDescription)")
            conditionImageView.image = UIImage(systemName: "question")
            tempLabel.text = "- -"
            cityLabel.text = "- - -"
        }
    }
    
    func requestDataHandler(response: HTTPURLResponse, data: Data?) {
        if let data {
            do {
                let weatherModel = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                let weatherInfo = WeatherModel(from: weatherModel)
                print("Received data: \(weatherModel)")
                conditionImageView.image = UIImage(systemName: weatherInfo.iconName)
                tempLabel.text = weatherInfo.temp
                cityLabel.text = weatherInfo.cityName
                seeMoreWeatherInfo.isHidden = false
                viewModel.currentweatherInfo = weatherInfo
            } catch {
                print("Failed to decode data: \(error)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occured: \(error.localizedDescription)")
    }
}
