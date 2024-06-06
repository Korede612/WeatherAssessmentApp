//
//  DataStorable.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import Foundation

protocol DataStorable: DataCodableInterface {
    func retrieveData<T: Codable>(for account: String, type: T.Type) -> T?
    func preserveToUserdefault<T: Codable>(_ value: T, account: String)
}

extension DataStorable {
    // MARK: - Secret data retrieval
    
    //MARK: This is for any type of data from Userdefault
    func retrieveData<T: Codable>(for account: String, type: T.Type) -> T? {
        do {
            if let data = try UserdefaultManager.get(account: account) {
                let decodedData = decode(type, from: data)
                return decodedData
            }
            return nil
        }
        catch {
            return nil
        }
    }
    
    // MARK: - Secret data storage into Userdefault
    func preserveToUserdefault<T: Codable>(_ value: T, account: String) {
        if let codedValue = encode(value) {
            do {
                try UserdefaultManager.put(value: codedValue, account: account)
            }
            catch {
                return
            }
        }
    }
    
    // MARK: - Delete Specific data stored in Userdefault
    func deleteSpecificStoredUserdefault(account: String) {
        do {
            try UserdefaultManager.delete(account: account)
        } catch {
            return
        }
    }
   
    // MARK: - Delete All data stored in Userdefault
    func deleteAllStoredUserdefault() {
        do {
            try UserdefaultManager.deleteAll()
        } catch {
            print(error.localizedDescription)
        }
    }
}
