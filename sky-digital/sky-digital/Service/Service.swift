//
//  Service.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import Foundation
import Alamofire

class Service : ServiceProtocol {
    func getData(from url: String, parameters: Parameters?, callBack: @escaping CallBack) throws {
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            throw ConnectErrors.receivedFailure
        }

        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = parameters as? [String : String]

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                callBack(nil, false, error.debugDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode)
                callBack(data, true, "")
            }
        })

        dataTask.resume()
        
//        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
//            (responseData) in
//            switch responseData.result {
//            case .failure(let error):
//                callBack(nil, false, error.errorDescription ?? "")
//            case .success(_):
//                guard let data = responseData.data else {
//                    callBack(nil, false, "API response did not return data")
//                    return
//                }
//                
//                do {
//                    if responseData.response?.statusCode == 200 {
//                        callBack(data, true, "")
//                    } else {
//                        let errorMessage = try JSONDecoder().decode(ErrorMessage.self, from: data)
//                        callBack(nil, false, errorMessage.status)
//                    }
//                } catch {
//                    callBack(nil, false, error.localizedDescription)
//                }
//            }
//        }
    }
}
