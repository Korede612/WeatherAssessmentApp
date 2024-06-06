//
//  NetworkInterface.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 05/06/2024.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get = "GET"        // Other requests can be added here
}

protocol APIKey {
    var apiKey: String { get }
}

extension APIKey {
    var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as! String
    }
}

enum APIEndpoint: APIKey {
    case fetchWeatherDataFor(loc: String)
    case fetchWeatherDataUsing(lat: String, lon: String)
    
    var url: URL {
        switch self {
        case .fetchWeatherDataFor(let loc):
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric&q=\(loc)")!
        case .fetchWeatherDataUsing(let lat, let lon):
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric&lat=\(lat)&lon=\(lon)")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchWeatherDataFor, .fetchWeatherDataUsing:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
}

protocol NetworkRouterProvider {
    func request(endpoint: APIEndpoint) -> AnyPublisher<(HTTPURLResponse, Data?), Error>
}

//extension NetworkRouterProvider {
//    func request<T: Codable>(endpoint: APIEndpoint) -> AnyPublisher<(HTTPURLResponse, T?), Error> {
//        var request = URLRequest(url: endpoint.url)
//        request.httpMethod = endpoint.method.rawValue
//        
//        if let parameters = endpoint.parameters {
//            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        }
//        
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { data, response -> (HTTPURLResponse, T?) in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    throw URLError(.badServerResponse)
//                }
//                
//                let decoder = JSONDecoder()
//                let decodedData = try? decoder.decode(T.self, from: data)
//                
//                return (httpResponse, decodedData)
//            }
//            .eraseToAnyPublisher()
//    }
//}
