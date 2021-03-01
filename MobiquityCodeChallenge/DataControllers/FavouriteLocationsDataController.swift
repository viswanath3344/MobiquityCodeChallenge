//
//  FavouriteLocationsController.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 27/02/21.
//

import UIKit

class FavouriteLocationsDataController: NSObject {
    static let shared = FavouriteLocationsDataController()
    var locations: [FavouriteLocation] = []
    
    override init(){
        super.init()
        self.getDataFromUserDefaults()
    }
    
    func addLocation(location: FavouriteLocation) -> Bool  {
        if !checkForExists(location: location) {
            locations.append(location)
            saveDataToUserDefaults()
            return true
        }
        return false
    }
    
    func removeLocation(location: FavouriteLocation) {
        if let indexOfLocation = locations.firstIndex(where: { $0.latitude == location.latitude && $0.longitude == location.longitude}){
            locations.remove(at: indexOfLocation)
            saveDataToUserDefaults()
        }
    }
    func removeAllLocations () {
        locations.removeAll()
        saveDataToUserDefaults()
    }
    
    private func saveDataToUserDefaults(){ // Save faviourite locations to user defaults
        UserDefaults.standard.set(try? PropertyListEncoder().encode(locations), forKey:"fLocations")
    }
    private func getDataFromUserDefaults(){  // get faviourite locations from user defaults
        if let data = UserDefaults.standard.value(forKey:"fLocations") as? Data {
            if let locations1 = try? PropertyListDecoder().decode(Array<FavouriteLocation>.self, from: data) {
                self.locations = locations1
            }
            
        }
    }
    
    func checkForExists(location: FavouriteLocation) -> Bool  {
       return locations.contains(where: {$0.city == location.city && $0.country == location.country})
       
    }
    
}
