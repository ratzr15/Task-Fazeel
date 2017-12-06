//
//  WeatherService.swift
//  Task-Fazeel
//
//  Created by Faz on 12/4/17.
//  Copyright © 2017 Faz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class WeatherService {
    let weatherApiKey : String
    let weatherBaseUrl : URL?
    let imageBaseUrl : URL?

    
    init(Apikey: String) {
        self.weatherApiKey = Apikey
        weatherBaseUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?")
        imageBaseUrl = URL(string: "https://openweathermap.org/img/w/")
    }
    
    //for fetching the weather api
    func getCurrentWeather(cityName: String , completion: @escaping (_ result: [CurrentWeather]) -> Void)  {
        let city = String(format : "q=%@" , cityName)
        let appID = String(format : "APPID=%@" , self.weatherApiKey)
        
        let string = "\(weatherBaseUrl!)\(city)&\(appID)"
        
        let urlwithPercentEscapes = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        if let weatherUrl = URL(string: urlwithPercentEscapes!) {
            var weatherArray = [CurrentWeather]()

            Alamofire.request(weatherUrl).responseJSON(completionHandler:
                { (response) in
                    if let jsonDict = response.result.value as? [String : Any] {
                        print(jsonDict)
                        
                        var weatherModelObject: CurrentWeather?

                        if let list = jsonDict[CurrentWeather.kList] as? [[String : Any]] {
                            for name in list {
                                weatherModelObject = CurrentWeather(jsonDictionary: name)
                                if weatherArray.contains(where: { $0.date == weatherModelObject?.date }) {
                                    // found
                                } else {
                                    weatherArray.append(weatherModelObject!)

                                }
                            }
                        }
                        
                        completion(weatherArray)
                   
                    }
                    else{
                        completion(weatherArray)
                    }
            })
        }
        else{
            
        }

    }
    
    //for fetching the images
    func getUrl(img: String) -> URL {
            let url = URL(string: "\(imageBaseUrl!)\(img).png")!
        return url
    }
    

}
