//
//  LWLocationModel.swift
//  Metaweather
//
//  Created by vpankina on 03/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

public class LWLocationModel: NSObject {
    public var title: String?
    public var location_type: String?
    public var woeid: Int?
    public var latt_long: String?
    public var sources: [LWSourceModel]?
    
    init(from model:LWLocationResponse) {
        self.title = model.title
        self.location_type = model.location_type
        self.woeid = model.woeid
        self.latt_long = model.latt_long
    }
}
