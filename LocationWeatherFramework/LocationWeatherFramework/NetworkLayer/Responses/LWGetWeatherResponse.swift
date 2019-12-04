//
//  LWGetWeatherResponse.swift
//  Metaweather
//
//  Created by vpankina on 02/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWGetWeatherResponse: LWBaseResponse, Decodable {
    var consolidated_weather: [LWWeatherRo]?
    var time: String?
    var sun_rise: String?
    var sun_set: String?
    var timezone_name: String?
    var parent: LWLocationRo?
    var title: String?
    var location_type: String?
    var woeid: Int?
    var latt_long: String?
    var timezone: String?
}
