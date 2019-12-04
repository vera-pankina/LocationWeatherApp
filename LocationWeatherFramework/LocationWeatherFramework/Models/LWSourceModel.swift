//
//  LWSourceModel.swift
//  LocationWeatherFramework
//
//  Created by vpankina on 04/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

public class LWSourceModel: NSObject {
    public var title: String?
    public var slug: String?
    public var url: String?
    public var crawl_rate: Int?
    
    init(from model:LWSourceRo) {
        self.title = model.title
        self.slug = model.slug
        self.url = model.url
        self.crawl_rate = model.crawl_rate
    }
}
