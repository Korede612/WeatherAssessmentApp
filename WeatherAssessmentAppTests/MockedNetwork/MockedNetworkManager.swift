//
//  MockedNetworkManager.swift
//  WeatherAssessmentAppTests
//
//  Created by Oko-osi Korede on 06/06/2024.
//

@testable import WeatherAssessmentApp
import Combine
import Foundation

class MockedNetworkManager: NetworkRouterProvider {
    func request(endpoint: WeatherAssessmentApp.APIEndpoint) -> AnyPublisher<(HTTPURLResponse, Data?), Error> {
        guard let url = Bundle.main.url(forResource: "MockedResponse", withExtension: "json") else {
            return Fail(error: URLError(.fileDoesNotExist)).eraseToAnyPublisher()
        }
        
        do {
            // Read the JSON file data
            let data = try Data(contentsOf: url)
            let httpResponse = HTTPURLResponse(url: endpoint.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            
            return Just((httpResponse, data))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    
}

