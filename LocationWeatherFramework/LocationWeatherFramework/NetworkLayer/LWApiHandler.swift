//
//  LWApiHandler.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import Alamofire

class LWApiHandler<T: LWBaseResponse> where T: Decodable {
    typealias ResultCompletion = (_ response: T) -> Void
    typealias ErrorCompletion = (_ error: LWErrorRo) -> Void

    var resultCompletion: ResultCompletion?
    var errorCompletion: ErrorCompletion?

    init(result: ResultCompletion?, error: ErrorCompletion?) {
        self.resultCompletion = result
        self.errorCompletion = error
    }
        
    var finishData: (DataResponse<Data>) -> Void {
        get {
            return { result in
                let response = result

                let statusCode = response.response?.statusCode

                switch response.result {
                case .success(let json):
                    print(json)
                    let decoder = JSONDecoder()
                    let jsonString = String(data: json, encoding: .utf8); print("JSON: \(String(describing: jsonString))")
                    if var jsonString = jsonString {
                        if jsonString.first == "[", jsonString.last == "]" {
                            jsonString.removeSubrange( jsonString.startIndex ..< jsonString.index(after: jsonString.startIndex))
                            jsonString.removeSubrange( jsonString.index(before: jsonString.endIndex) ..<  jsonString.endIndex)
                        }
                        if let jsonData = jsonString.data(using: .utf8) {
                            if let decodedObject = try? decoder.decode(T.self, from: jsonData ) {
                            if statusCode == 200 {
                                if let completion = self.resultCompletion {
                                    completion(decodedObject)
                                    }
                                } else {
                                    if let completion = self.errorCompletion {
                                        completion(LWErrorRo(code: 0, message: "Что-то пошло не так..."))
                                    }
                                }
                            } else {
                                debugPrint("Error: object of type \(T.self) does not parse")
                                if let completion = self.errorCompletion {
                                    completion(LWErrorRo(code: 0, message: "Что-то пошло не так..."))
                                }
                            }
                        }
                    }
                case .failure(let error):
                    if let errorRo = self.handleFailureCodes(error: error) {
                        if let completion = self.errorCompletion {
                            completion(errorRo)
                        }
                    }
                }
            }
        }
    }
    
    private func handleError(response: T, code: NSNumber, message: String) {
        if let completion = self.errorCompletion {
            completion(LWErrorRo(code: code.intValue,
                    message: message))
        }
    }
    
    func handleFailureCodes(error: Error) -> LWErrorRo? {
        switch error._code {
        case NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost:
            return LWErrorRo(code: error._code, message: "Интернет-соединение недоступно")

        case NSURLErrorTimedOut:
            return LWErrorRo(code: error._code, message: "Сервер недоступен, повторите попытку позже")

        default: return LWErrorRo(code: error._code, message: "Что-то пошло не так...")
        }
    }
}
