//
//  DataCodableInterface.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import Foundation
protocol DataCodableInterface {
    func encode<T: Codable>(_ value: T) -> Data?
    func decode<T: Codable>(_ type: T.Type, from data: Data) -> T?
}

extension DataCodableInterface {
    func encode<T: Codable>(_ value: T) -> Data? {
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(value)
            return encodedData
        }
        catch {
            return nil
        }
    }
    
    func decode<T: Codable>(_ type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        }
        catch {
            return nil
        }
    }
}
