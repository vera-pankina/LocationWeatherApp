//
//  LWNetworkManager.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWNetworkManager: LWBaseNetworkManager {
    
    enum WeatherListPath: String {
        case location = "/api/location/search/"
        case weather = "/api/location/"
    }

    func getLocation(request: LWGetLocationRequest, handler: LWApiHandler<LWLocationResponse>) {
        self.get(path: WeatherListPath.location.rawValue, request: request, handler: handler)
    }
    
    func getWeather(request: LWGetWeatherRequest, handler: LWApiHandler<LWGetWeatherResponse>) {
        let woeid = (request.woeid as NSNumber).stringValue
        if !woeid.isEmpty {
            self.get(path: WeatherListPath.weather.rawValue + woeid + "/", request: request, handler: handler)
        }
    }
}
