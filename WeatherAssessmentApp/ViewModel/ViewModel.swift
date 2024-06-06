//
//  ViewModel.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 05/06/2024.
//

import Foundation

protocol ViewModelInterface: DataStorable {
    var currentweatherInfo: WeatherModel? { get set }
    var networkManager: NetworkRouterProvider? { get set }
    var savedLocation: [String] { get set }
    func saveCurrentLocation(location: String, path: String)
    func getSavedLocations(path: String) -> [String]
    func deleteLocation(location: String, path: String)
    func updateSavedLocation()
}

class ViewModel: ViewModelInterface {
    var currentweatherInfo: WeatherModel?
    var savedLocation: [String]
    
    var networkManager: NetworkRouterProvider?
    
    init(networkManager: NetworkRouterProvider) {
        self.networkManager = networkManager
        self.savedLocation = []
        savedLocation = getSavedLocations()
    }
    
    func updateSavedLocation() {
        savedLocation = getSavedLocations()
    }
    
    
}

extension ViewModelInterface {
    func getSavedLocations(path: String = "Locations") -> [String] {
        return retrieveData(for: path, type: [String].self) ?? []
    }
    
    func deleteLocation(location: String, path: String = "Locations") {
        let newSavedLocation = savedLocation.filter({$0 != location})
        preserveToUserdefault(newSavedLocation, account: path)
    }
    
    func saveCurrentLocation(location: String, path: String = "Locations") {
        var preservedData = getSavedLocations()
        if !preservedData.contains(location) {
            preservedData.append(location)
        }
        preserveToUserdefault(preservedData, account: path)
    }
}
