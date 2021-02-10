//
//  Service.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import Foundation

public class Service : ServiceProtocol {
    func getData(from url: String, parameters: [String : String]?, callBack: @escaping CallBack) throws {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = parameters

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if (error != nil) {
                callBack(nil, false, error.debugDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode)
                if httpResponse?.statusCode == 200 {
                    callBack(data, true, "")
                } else {
                    callBack(nil, false, httpResponse.debugDescription)
                }
            }
        })

        dataTask.resume()

    }
}
