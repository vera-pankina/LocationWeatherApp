//
//  LWLocationRo.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWLocationRo: NSObject, Decodable {
    var title: String?
    var location_type: String?
    var woeid: Int?
    var latt_long: String?
    var sources: [LWSourceRo]?
}
