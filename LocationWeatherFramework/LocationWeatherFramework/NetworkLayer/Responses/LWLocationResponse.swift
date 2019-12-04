//
//  LWLocationResponse.swift
//  Metaweather
//
//  Created by vpankina on 02/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWLocationResponse: LWBaseResponse, Decodable {
    var title: String?
    var location_type: String?
    var woeid: Int?
    var latt_long: String?
    
//    enum CodingKeys: String, CodingKey {
//      case title
//      case location_type
//      //case woeid
//      case latt_long
//    }
//    
//    required init(from decoder: Decoder) throws {
//      let container = try decoder.container(keyedBy: CodingKeys.self)
//      title = try container.decode(String.self, forKey: .title)
//      location_type = try container.decode(String.self, forKey: .location_type)
//        //woeid?.value = try container.decode(Int.self, forKey: .woeid)
//      latt_long = try container.decode(String.self, forKey: .latt_long)
//    }
}
