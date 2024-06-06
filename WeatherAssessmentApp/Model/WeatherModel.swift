//
//  WeatherModel.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 05/06/2024.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Float
    
    let minTemp: Float
    let maxTemp: Float
    let humidity: Float
    
    let description: String
    
    var temp: String {
        return String(format: "%.1f", temperature)
    }
    var iconName: String {
        switch conditionId {
        case 200 ... 232:
            return "cloud.bolt"
        case 300 ... 321:
            return "cloud.drizzle"
        case 500 ... 531:
            return "cloud.rain"
        case 600 ... 622:
            return "cloud.snow"
        case 700 ... 781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801 ... 804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

extension WeatherModel {
    init(from weatherData: WeatherDataModel) {
        self.cityName = weatherData.name
        self.conditionId = weatherData.weather[0].id
        self.temperature = weatherData.main.temp
        self.minTemp = weatherData.main.minTemp
        self.maxTemp = weatherData.main.maxTemp
        self.humidity = weatherData.main.humidity
        self.description = weatherData.weather.first?.description ?? "No description"
    }
}
