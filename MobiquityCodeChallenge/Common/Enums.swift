//
//  Enums.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 28/02/21.
//

import Foundation

enum Units: String{
   case metric, imperial
}

enum DateFormats: String{
   case format1 = "dd/MM/YYYY HH:mm: a"
   case format2 = "MM/dd/YYYY HH:mm: a"
    
}

enum TemparatureUnits: String{
    case metric = "°C"
    case imperial = "°F"
}

enum WindUnits: String {
    case metric = "meter/sec"
    case imperial = "miles/hour"
}
