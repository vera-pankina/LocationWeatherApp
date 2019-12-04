//
//  LWWeatherManager.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

public class LWWeatherManager {
    
    private var networkManager: LWNetworkManager
    
    public static let shared  = LWWeatherManager()
    private init() {
        networkManager = LWNetworkManager()
    }
    
    public typealias GetLocationCompletion = (_ location: LWLocationModel?, _ error: String?) -> Void
    public typealias GetWeatherCompletion = (_ location: LWWeatherModel?, _ error: String?) -> Void
    
    public func getLocation(location: String, completion: @escaping(GetLocationCompletion)) {
        let request = LWGetLocationRequest(location: location)
        networkManager.getLocation(request: request, handler: LWApiHandler<LWLocationResponse>(result: { (response) in
            completion(LWLocationModel(from: response), nil)
        }, error: { (error) in
            completion(nil, error.message)
        }))
    }
    
    public func getWeather(woeid: Int, completion: @escaping(GetWeatherCompletion)) {
        let request = LWGetWeatherRequest(woeid: woeid)
        networkManager.getWeather(request: request, handler: LWApiHandler<LWGetWeatherResponse>(result: { (response) in
            if let consolidated_weather = response.consolidated_weather, consolidated_weather.count > 0 {
                completion(LWWeatherModel(from: consolidated_weather[0]), nil)
            } else {
                debugPrint("consolidated_weather equal nil")
                completion(nil, "Что-то пошло не так...")
            }
        }, error: { (error) in
            completion(nil, error.message)
        }))
    }

    public func getWeather(location: String, completion: @escaping(GetWeatherCompletion)) {
        getLocation(location: location) {
            [weak self] (location, error) in
            guard let self = self else { return }
            guard error == nil else { return completion(nil, error) }
            if let location = location, let woeid = location.woeid {
                self.getWeather(woeid: woeid) {
                    (weather, error) in
                    guard error == nil else { return completion(nil, error) }
                    if let weather = weather {
                        completion(weather, nil)
                    } else {
                        debugPrint("weather equal nil")
                        completion(nil, "Что-то пошло не так...")
                    }
                }
                    
             } else {
                 debugPrint("location or woeid equal nil")
                 completion(nil, "Что-то пошло не так...")
             }
        }
        
    }
}
