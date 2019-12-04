//
//  LWGetWeatherRequest.swift
//  Metaweather
//
//  Created by vpankina on 02/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWGetWeatherRequest: LWBaseRequest {
    var woeid: Int
    
    init(woeid: Int) {
        self.woeid = woeid
    }

    override func parameters() -> [String : String] {
        return [String : String]()
    }
}
