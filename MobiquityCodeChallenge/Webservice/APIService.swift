//
//  APIService.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 28/02/21.
//

import Foundation

class APIService :  NSObject {
    
    func apiToGetCurrentWeatherData(sourceURL:URL, completion : @escaping (WeatherInfo?, String?) -> ()){
        URLSession.shared.dataTask(with: sourceURL) { (data, urlResponse, error) in
            
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let weather = try decoder.decode(WeatherInfo.self, from: data)
                   // print(weather as Any)
                    completion(weather,nil)
                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                    completion(nil, context.debugDescription)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil, context.debugDescription)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil, context.debugDescription)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil, context.debugDescription)
                } catch {
                    print("error: ", error)
                    completion(nil, error.localizedDescription)
                }
            }else {
                completion(nil, error?.localizedDescription)
            }
            
        }.resume()
    }
func apiToGetForecastWeatherData(sourceURL:URL, completion : @escaping (ForecastWeather?, String?) -> ()){
    URLSession.shared.dataTask(with: sourceURL) { (data, urlResponse, error) in
        
        if error != nil {
            completion(nil, error?.localizedDescription)
        }
        
        if let data = data {
            
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(ForecastWeather.self, from: data)
               // print(weather as Any)
                completion(weather,nil)
            } catch DecodingError.dataCorrupted(let context) { // debugging for JSON parsing.
                print(context)
                completion(nil, context.debugDescription)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, context.debugDescription)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, context.debugDescription)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(nil, context.debugDescription)
            } catch {
                print("error: ", error)
                completion(nil, error.localizedDescription)
            }
        }else {
            completion(nil, error?.localizedDescription)
        }
        
    }.resume()
}

}
