//
//  NetworkManager.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 05/06/2024.
//

import Foundation
import Combine

class NetworkManager: NetworkRouterProvider {
    
    func request(endpoint: APIEndpoint) -> AnyPublisher<(HTTPURLResponse, Data?), Error> {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method.rawValue
        
        if let parameters = endpoint.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        print("here is the endpoint: \(endpoint.url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> (HTTPURLResponse, Data?) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                return (httpResponse, data)
            }
            .eraseToAnyPublisher()
    }
}
