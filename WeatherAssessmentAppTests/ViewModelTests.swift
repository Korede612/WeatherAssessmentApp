//
//  ViewModelTests.swift
//  WeatherAssessmentAppTests
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import XCTest
@testable import WeatherAssessmentApp
import Combine
import Foundation

final class ViewModelTests: XCTestCase {

    var viewModel: ViewModelInterface?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewModel = ViewModel(networkManager: MockedNetworkManager())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testNeworkmanager() throws {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel?.networkManager)
    }
    
    func testFetchWeatherForLocation() throws {
        viewModel?.networkManager?.request(endpoint: .fetchWeatherDataFor(loc: "Cupertino"))
            .sink(receiveCompletion: { completion in
                print("\(completion)")
            }, receiveValue: { response, data in
                XCTAssertNotNil(response)
                XCTAssertNotNil(data)
                
                if let data {
                    do {
                        let weatherModel = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                        let weatherInfo = WeatherModel(from: weatherModel)
                        print("Received data: \(weatherModel)")
                        XCTAssertEqual(weatherInfo.cityName, "Cupertino")
                        XCTAssertEqual(weatherInfo.conditionId, 800)
                        XCTAssertEqual(weatherInfo.description, "clear sky")
                        XCTAssertEqual(weatherInfo.humidity, 62)
                        XCTAssertEqual(weatherInfo.maxTemp, 26.83)
                        XCTAssertEqual(weatherInfo.minTemp, 11.49)
                        XCTAssertEqual(weatherInfo.temp, "21.4")
//                        viewModel?.currentweatherInfo = weatherInfo
                    } catch {
                        print("Failed to decode data: \(error)")
                    }
                }
                    
            })
            .store(in: &cancellables)
    }
    
    func testSavedLocations() throws {
        viewModel?.saveCurrentLocation(location: "Lagos", path: "test_saved_location")
        let locations = viewModel?.getSavedLocations(path: "test_saved_location")
        XCTAssertNotNil(locations)
        XCTAssertEqual(locations?.count, 1)
        XCTAssertEqual(locations?.first, "Lagos")
    }
    
    func testDeleteLocation() throws {
        viewModel?.saveCurrentLocation(location: "Lagos", path: "test_saved_location")
        var locations = viewModel?.getSavedLocations(path: "test_saved_location")
        XCTAssertNotNil(locations)
        XCTAssertEqual(locations?.count, 1)
        viewModel?.deleteLocation(location: "Lagos", path: "test_saved_location")
        locations = viewModel?.getSavedLocations(path: "test_saved_location")
        XCTAssertNotNil(locations)
        XCTAssertEqual(locations?.count, 0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
