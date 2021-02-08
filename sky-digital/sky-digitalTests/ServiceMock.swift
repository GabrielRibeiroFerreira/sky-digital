//
//  ServiceMock.swift
//  sky-digitalTests
//
//  Created by Ribeiro Ferreira on 05/02/21.
//

import Foundation
@testable import sky_digital

class ServiceMock : ServiceProtocol {
    let listResponse : [String] = ["/title/tt5034838/"]
    
    
    let movieResponse : [String : Any] = [
        "title":
           [
              "id":"/title/tt5034838/",
              "title":"Godzilla vs. Kong"
           ],
        "releaseDate":"2020-08-20",
        "id":"/title/tt5034838/",
        "plotSummary":
           [
              "text":"Legends collide as Godzilla and Kong, the two most powerful forces of nature, clash on the big screen in a spectacular battle for the ages. As a squadron embarks on a perilous mission into fantastic uncharted terrain, unearthing clues to the Titans' very origins and mankind's survival, a conspiracy threatens to wipe the creatures, both good and bad, from the face of the earth forever."
           ]
        ]
    
    
    
    func getData(from url: String, parameters: [String:String]?, callBack: @escaping CallBack) throws {
        do {
            var jsonData: Data
            if url.contains("get-most-popular-movies") {
                jsonData = try JSONSerialization.data(withJSONObject: self.listResponse, options: [])
            } else {
                jsonData = try JSONSerialization.data(withJSONObject: self.movieResponse, options: [])
            }
            
            callBack(jsonData, true, "")
        } catch {
            print(error)
        }
    }
}

