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
            })
            .store(in: &cancellables)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
