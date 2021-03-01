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
    
    func resetSettings(){
        UserDefaults.standard.removeObject(forKey: "Units")
        UserDefaults.standard.removeObject(forKey: "dateFormat")
        selectedUnit = Units.metric
        selectedDateFormat = DateFormats.format1
    }
    
     func getDataFromUserDefaults(){  // get faviourite locations from user defaults
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
    
    func getUnitsForTemparature() -> String  {
        switch selectedUnit {
        case .metric:
            return TemparatureUnits.metric.rawValue
        case .imperial:
            return TemparatureUnits.imperial.rawValue
        }
    }
    
    func getUnitsForWind() -> String  {
        switch selectedUnit {
        case .metric:
            return WindUnits.metric.rawValue
        case .imperial:
            return WindUnits.imperial.rawValue
        }
    }
    
    func getFormattedDate(timeStamp:Int) -> String  {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        
        switch selectedDateFormat {
        case .format1:
            dateFormatter.dateFormat = DateFormats.format1.rawValue
        case .format2:
            dateFormatter.dateFormat = DateFormats.format2.rawValue
        }
        return dateFormatter.string(from: date)
    }
    
    func getUnitsForRainChances() -> String {
        return "%"
    }
    
    func getUnitsForHumidity() -> String {
        return "%"
    }
    
}
