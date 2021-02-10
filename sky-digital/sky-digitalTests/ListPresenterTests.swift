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
    var service = ServiceMock()
    
    override func setUp() {
        super.setUp()
        
        Cache.defaults = MockUserDefaults()
        
        self.listPresenter = ListPresenter(service: self.service)
    }
    
    func testDecode() {
        var title : String?
        
        let exp = expectation(description: "Test after 1 seconds, wait for callback")
        
        self.listPresenter.getData { (listData, status, message) in
            guard let list = listData else { return }
            title = list.first?.title?.title
            
            XCTAssertEqual(title, "Godzilla vs. Kong", "getting movie from service error")
            
            var serviceCalled: Bool = false
            self.service.getCall = { url in
                serviceCalled = true
            }
            self.listPresenter.getData { (list, status, message) in
                XCTAssertTrue(!serviceCalled, "getting movie from cache error")
                
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
