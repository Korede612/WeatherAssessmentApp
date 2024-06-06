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
    func saveCurrentLocation(location: String)
    func getSavedLocations() -> [String]
    func deleteLocation(location: String)
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
    
    func saveCurrentLocation(location: String) {
        var preservedData = getSavedLocations()
        if !preservedData.contains(location) {
            preservedData.append(location)
        }
        
        preserveToUserdefault(preservedData, account: "Locations")
    }
    
    func deleteLocation(location: String) {
        let newSavedLocation = savedLocation.filter({$0 != location})
        preserveToUserdefault(newSavedLocation, account: "Locations")
        savedLocation = getSavedLocations()
    }
    
    func updateSavedLocation() {
        savedLocation = getSavedLocations()
    }
    
    func getSavedLocations() -> [String] {
        return retrieveData(for: "Locations", type: [String].self) ?? []
    }
}
