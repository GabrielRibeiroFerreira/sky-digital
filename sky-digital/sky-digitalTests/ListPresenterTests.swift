//
//  ListPresenterTests.swift
//  sky-digitalTests
//
//  Created by Ribeiro Ferreira on 05/02/21.
//

import XCTest
@testable import sky_digital

class MockUserDefaults: UserDefaults {
    private var data: [String: Any?] = [:]
    
    override func set(_ value: Any?, forKey defaultName: String) {
        self.data[defaultName] = value
    }
    
    override func data(forKey defaultName: String) -> Data? {
        return self.data[defaultName] as? Data
    }
    
    override func object(forKey defaultName: String) -> Any? {
        return self.data[defaultName] ?? nil
    }
}

class ListPresenterTests: XCTestCase {
    var listPresenter : ListPresenter!
    
    override func setUp() {
        super.setUp()
        
        Cache.defaults = MockUserDefaults()
        
        self.listPresenter = ListPresenter(service: ServiceMock())
    }
    
    func testDecode() {
        var title : String?
        var key: String?
        
        let exp = expectation(description: "Test after 1 seconds, wait for callback")
        
        self.listPresenter.getData { (listData, status, message) in
            guard let list = listData else { return }
            title = list.first?.title?.title
            key = list.first?.id
            
            XCTAssertEqual(title, "Godzilla vs. Kong", "getting movie from service error")
            
            title = nil
            if let k = key {
                let movie = self.listPresenter.getMovieFromCache(key: k)
                title = movie?.title?.title
            }

            XCTAssertEqual(title, "Godzilla vs. Kong", "getting movie from cache error")
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
