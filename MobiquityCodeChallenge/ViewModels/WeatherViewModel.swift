//
//  WeatherViewModel.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 28/02/21.
//

import UIKit

class WeatherViewModel: NSObject {
    
    private var apiService : APIService!
    private(set) var weatherInfo : WeatherInfo! {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }
    
    private(set) var forecastWeatherInfo : ForecastWeather! {
        didSet {
            self.bindForecastWeatherViewModelToController()
        }
    }
    
    var bindWeatherViewModelToController : (() -> ()) = {}
    var bindForecastWeatherViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        //callFuncToGetEmpData()
    }
    
    func callFuncToGetCuurentWeatherData(location:FavouriteLocation) {
        
        var weatherURlString =  weatherBaseURL
        weatherURlString = weatherURlString.replacingOccurrences(of: "#LAT#", with: String(location.latitude), options: .literal, range: nil)
        weatherURlString = weatherURlString.replacingOccurrences(of: "#LON#", with: String(location.longitude), options: .literal, range: nil)
        weatherURlString = weatherURlString.replacingOccurrences(of: "#UNITS#", with: SettingsDataController.shared.selectedUnit.rawValue, options: .literal, range: nil)
        
        
        guard let sourceUrl = URL(string: weatherURlString) else {
            return
        }
        
        
        self.apiService.apiToGetCurrentWeatherData(sourceURL: sourceUrl, completion: { (weatherInfo, error) in
            
            if weatherInfo != nil {
                self.weatherInfo = weatherInfo
            }else {
                print("Error Occured", error ?? "")
            }
        })
    }
    func callFuncToGetForecastWeatherData(location:FavouriteLocation) {
        var weatherURlString =  forecaseBaseURL
        weatherURlString = weatherURlString.replacingOccurrences(of: "#LAT#", with: String(location.latitude), options: .literal, range: nil)
        weatherURlString = weatherURlString.replacingOccurrences(of: "#LON#", with: String(location.longitude), options: .literal, range: nil)
        weatherURlString = weatherURlString.replacingOccurrences(of: "#UNITS#", with: SettingsDataController.shared.selectedUnit.rawValue, options: .literal, range: nil)
        
        
        guard let sourceUrl = URL(string: weatherURlString) else {
            return
        }
    
        self.apiService.apiToGetForecastWeatherData(sourceURL: sourceUrl, completion: { (weatherInfo, error) in
            
            if weatherInfo != nil {
                self.forecastWeatherInfo = weatherInfo
            }else{
                print("Error Occured",error ?? "")
            }
            
        })
    }
}
