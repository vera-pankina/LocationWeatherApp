//
//  LWWeatherModel.swift
//  Metaweather
//
//  Created by vpankina on 03/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

public class LWWeatherModel: NSObject {
    public var id: Int?
    public var weather_state_name: String?
    public var min_temp: Double?
    public var max_temp: Double?
    public var the_temp: Double?
    public var wind_speed: Double?
    public var wind_direction: Double?
    
    override init() {
        super.init()
    }
    
    init(from model:LWWeatherRo) {
        self.id = model.id
        self.weather_state_name = model.weather_state_name
        self.min_temp = model.min_temp
        self.max_temp = model.max_temp
        self.the_temp = model.the_temp
        self.wind_speed = model.wind_speed
        self.wind_direction = model.wind_direction
    }
}
