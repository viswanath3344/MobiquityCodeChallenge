
//
//  CurrentWeatherInfo.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 28/02/21.
//

import Foundation

// MARK: - Welcome
struct ForecastWeather: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherList]?
    let city: CityStruct?
}

// MARK: - City
struct CityStruct: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}


// MARK: - List
struct WeatherList: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let snow: Snow?
    let sys: Sys1
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, snow, sys
        case dtTxt = "dt_txt"
    }
}



// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Snow
struct Snow: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys1: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}


enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case snow = "Snow"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightSnow = "light snow"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

