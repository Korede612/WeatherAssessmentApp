//
//  Extension + VC + LocationDelegate.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import CoreLocation

//MARK: - CoreLocation Delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else {
            return
        }
        locationManager.stopUpdatingLocation()
        let lat = Float(userLocation.coordinate.latitude)
        let lon = Float(userLocation.coordinate.longitude)
        
//        weatherManager.fetchWeather(lat: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occured: \(error.localizedDescription)")
    }
}
