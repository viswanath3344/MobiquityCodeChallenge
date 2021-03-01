//
//  FavouriteLocationsDataControllerTests.swift
//  MobiquityCodeChallengeTests
//
//  Created by Apple on 01/03/21.
//

import XCTest
@testable import MobiquityCodeChallenge

class DataControllerTests: XCTestCase {

    func testFavLocationDataController()  {
        
        // Test for When It had previous stored locations. Does it clear them or not.
        FavouriteLocationsDataController.shared.removeAllLocations()
        XCTAssertEqual(FavouriteLocationsDataController.shared.locations.count,0)
        
        
        let preCount = FavouriteLocationsDataController.shared.locations.count
        
        let location = FavouriteLocation(city: "Hyderabad", country: "India", latitude: 17.3850, longitude: 78.4867)
        
        // Does it able to add Location if not exists
        XCTAssertTrue(FavouriteLocationsDataController.shared.addLocation(location: location))
        
        // Does it able to give false when location is already exists with same city, country, latitude and longitude.
        XCTAssertFalse(FavouriteLocationsDataController.shared.addLocation(location: location))
        
        XCTAssertEqual(FavouriteLocationsDataController.shared.locations.count, preCount+1)
        
        
        FavouriteLocationsDataController.shared.removeLocation(location: location)
        XCTAssertEqual(FavouriteLocationsDataController.shared.locations.count, preCount)
        
    }
    
    
    func testSettingsDataController() {
        
        SettingsDataController.shared.resetSettings()
        
        XCTAssertEqual(SettingsDataController.shared.selectedUnit, Units.metric)
        
        SettingsDataController.shared.saveUnitSettings(unit: Units.imperial)
        XCTAssertEqual(SettingsDataController.shared.selectedUnit, Units.imperial)
        
        
        XCTAssertEqual(SettingsDataController.shared.selectedDateFormat, DateFormats.format1)
        SettingsDataController.shared.saveDateFormatSettings(dateFormat: DateFormats.format2)
        
        XCTAssertEqual(SettingsDataController.shared.selectedDateFormat, DateFormats.format2)
        
        
        // Checking the Data is properly stored in user defaults.
        SettingsDataController.shared.getDataFromUserDefaults()
        XCTAssertEqual(SettingsDataController.shared.selectedUnit, Units.imperial)
        XCTAssertEqual(SettingsDataController.shared.selectedDateFormat, DateFormats.format2)
        
        
        XCTAssertEqual(SettingsDataController.shared.getUnitsForTemparature(), TemparatureUnits.imperial.rawValue)
        XCTAssertEqual(SettingsDataController.shared.getUnitsForWind(), WindUnits.imperial.rawValue)
       
       
        let timeStamp = 1614581876
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.format2.rawValue
        let expectedResult = dateFormatter.string(from: date)
        // Checking for Format2 as per the above savings
        let actualResult = SettingsDataController.shared.getFormattedDate(timeStamp: timeStamp)
        XCTAssertEqual(actualResult, expectedResult)
        
        
        SettingsDataController.shared.resetSettings()
        XCTAssertEqual(SettingsDataController.shared.getUnitsForTemparature(), TemparatureUnits.metric.rawValue)
        XCTAssertEqual(SettingsDataController.shared.getUnitsForWind(), WindUnits.metric.rawValue)
    
        
        dateFormatter.dateFormat = DateFormats.format1.rawValue
        let expectedResult1 = dateFormatter.string(from: date)
        // Checking for Format1 as per the Reset settings
        let actualResult1 = SettingsDataController.shared.getFormattedDate(timeStamp: timeStamp)
        XCTAssertEqual(actualResult1, expectedResult1)
        
        XCTAssertEqual(SettingsDataController.shared.getUnitsForRainChances(), "%")
        XCTAssertEqual(SettingsDataController.shared.getUnitsForHumidity(), "%")
       
     }
}
