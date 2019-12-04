//
//  LWGetLocationRequest.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWGetLocationRequest: LWBaseRequest {
    var query: String
    
    init(location: String) {
        self.query = location
    }
    
    override func parameters() -> [String : String] {
        return ["query" : self.query]
    }
}
