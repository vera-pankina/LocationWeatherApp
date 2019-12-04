//
//  LWError.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit

class LWErrorRo: NSObject {
    var status: NSNumber?
    var message: String?
    
    init(code: Int?, message: String?) {
        if let code = code {
            self.status = NSNumber(integerLiteral: code)
        }
        self.message = message
    }
}
