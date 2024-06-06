//
//  WeatherDataModel.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 05/06/2024.
//

import Foundation

struct WeatherDataModel: Codable {
    let name: String
    let weather: [Weather]
    let main: MainWeather
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct MainWeather: Codable {
    let temp: Float
    let minTemp: Float
    let maxTemp: Float
    let humidity: Float
    
    enum CodingKeys: String, CodingKey {
        case temp
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case humidity
    }
    
}
