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
}

struct MainWeather: Codable {
    let temp: Float
}
