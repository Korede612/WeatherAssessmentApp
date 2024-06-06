//
//  Extension + ViewController + TextFieldDelegate.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import UIKit

//MARK: - UITextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSearch()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let tfText = textField.text, tfText != "" else {
            
            return false
        }
        return true
    }
}
