//
//  CurrentWeather.swift
//  Task-Fazeel
//
//  Created by Faz on 12/4/17.
//  Copyright © 2017 Faz. All rights reserved.
//

import Foundation
import UIKit

class CurrentWeather {
    static let kList = "list"
    static let kWeatherKey = "weather"
    static let kMainKey = "main"
    static let kDescriptionKey = "description"
    static let kIconKey = "icon"
    static let kTemperatureKey = "temp"
    static let kNameKey = "name"
    static let kDate = "dt_txt"

    
    var main = ""
    var description = ""
    var iconString = ""
    var iconImage: UIImage?
    var temperatureK: Float?
    var cityName = ""
    var date = ""
    var temperatureC: Float? {
        get {
            if let temperatureK = temperatureK {
                return temperatureK - 273.15
            } else {
                return nil
            }
        }
    }
    
    
    init(jsonDictionary: [String : Any]) {
        
        if let arrayUsingWeatherKey = jsonDictionary[CurrentWeather.kWeatherKey] as? [[String : Any]] {
            if let main = arrayUsingWeatherKey[0][CurrentWeather.kMainKey] as? String {
                self.main = main
            }
            if let description = arrayUsingWeatherKey[0][CurrentWeather.kDescriptionKey] as? String {
                self.description = description
            }
            if let iconString = arrayUsingWeatherKey[0][CurrentWeather.kIconKey] as? String {
                self.iconString = iconString
            }
        }
        
        if let main = jsonDictionary[CurrentWeather.kMainKey] as? [String : Any] {
            if let temperature = main[CurrentWeather.kTemperatureKey] as? NSNumber {
                self.temperatureK = Float(truncating: temperature)
            }
        }
        
        if let cityName = jsonDictionary[CurrentWeather.kNameKey] as? String {
            self.cityName = cityName
        }
        
        if let date = jsonDictionary[CurrentWeather.kDate] as? String {
            self.date = self.getDate(datestr: date)
        }
        
        
    }
    
}

extension CurrentWeather
{
    func getDate(datestr: String) -> String {
        
        let dateString: String = datestr
        let dateFormatter1: DateFormatter = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let yourDate: Date = dateFormatter1.date(from: dateString)!
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        print("\(dateFormatter1.string(from: yourDate))")
        return dateFormatter1.string(from: yourDate)
    }
}
