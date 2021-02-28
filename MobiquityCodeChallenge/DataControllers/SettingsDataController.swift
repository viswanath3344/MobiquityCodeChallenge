//
//  SettingsDataController.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 28/02/21.
//

import UIKit


class SettingsDataController: NSObject {
    
    static let shared = SettingsDataController()
    var selectedUnit = Units.metric
    var selectedDateFormat = DateFormats.format1
    
    override init(){
        super.init()
        self.getDataFromUserDefaults()
    }
    func saveUnitSettings(unit: Units)  {
        selectedUnit = unit
        saveDataToUserDefaults()
    }
    func saveDateFormatSettings(dateFormat: DateFormats)  {
        selectedDateFormat = dateFormat
        saveDataToUserDefaults()
    }
    
    private func saveDataToUserDefaults(){ // Save settings to user defaults
        UserDefaults.standard.setValue(selectedUnit.rawValue, forKey: "Units")
        UserDefaults.standard.setValue(selectedDateFormat.rawValue, forKey: "dateFormat")
    }
    
    private func getDataFromUserDefaults(){  // get faviourite locations from user defaults
        if let unit = UserDefaults.standard.value(forKey:"Units") as? String {
            if let unit = Units(rawValue: unit)  {
                selectedUnit = unit
            }
        }
        
        if let dateFormat = UserDefaults.standard.value(forKey:"dateFormat") as? String {
            if let dateFormat = DateFormats(rawValue: dateFormat){
                selectedDateFormat = dateFormat
            }
        }
    }
    
}
