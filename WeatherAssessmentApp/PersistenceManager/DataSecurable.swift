//
//  DataSecurable.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import Foundation
protocol DataSecurable {
    static func put(value: Data, account: String) throws
    static func get(account: String) throws -> Data?
    static func delete(account: String) throws
    static func deleteAll() throws
}
