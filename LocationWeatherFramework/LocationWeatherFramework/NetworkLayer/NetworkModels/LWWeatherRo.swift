//
//  LWWeatherRo.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWWeatherRo: Decodable {
    var id: Int?
    var weather_state_name: String?
    var weather_state_abbr: String?
    var wind_direction_compass: String?
    var created: String?
    var applicable_date: String?
    var min_temp: Double?
    var max_temp: Double?
    var the_temp: Double?
    var wind_speed: Double?
    var wind_direction: Double?
    var air_pressure: Double?
    var humidity: Int?
    var visibility: Double?
    var predictability: Int?
}
