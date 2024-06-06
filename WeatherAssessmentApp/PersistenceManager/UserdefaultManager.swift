//
//  UserdefaultManager.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import Foundation
public class UserdefaultManager: DataSecurable {
    
    static func put(value: Data, account: String) throws {
        UserDefaults.standard.set(value, forKey: account)
    }
    
    static func get(account: String) throws -> Data? {
        return UserDefaults.standard.data(forKey: account)
    }
    
    static func delete(account: String) throws {
        UserDefaults.standard.removeObject(forKey: account)
    }
    
    static func deleteAll() throws {
        if let identifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: identifier)
            UserDefaults.standard.synchronize()
        }
    }
}
