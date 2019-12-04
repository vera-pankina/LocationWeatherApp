//
//  LWBaseNetworkManager.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import Alamofire

class LWBaseNetworkManager {
    
    private let baseUrl = "https://www.metaweather.com"
    
    var sessionManager: Alamofire.SessionManager
    
    init() {
        sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }
    
    func get<T>(path: String, request: LWBaseRequest, handler: LWApiHandler<T>) {
        let request = sessionManager.request(
                baseUrl + path,
                method: .get,
                parameters: request.parameters(),
                headers: Alamofire.SessionManager.defaultHTTPHeaders
        ).responseData(completionHandler: handler.finishData)
        debugPrint(request)
    }
}
