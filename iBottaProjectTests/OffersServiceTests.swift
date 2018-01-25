//
//  OffersServiceTests.swift
//  iBottaProjectTests
//
//  Created by RICHARD TACKETT on 1/25/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import XCTest
@testable import iBottaProject

class OffersServiceTests: XCTestCase {
    func test_load_success() {
        //given
        class MockOffersLoader: OffersLoaderProtocol {
            func load(completion: @escaping (Result<Data>) -> Void) {
                let offer: [String: Any] = ["id":"110579",
                                            "url":"https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
                                            "name":"Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
                                            "description":"Any variety - 2 ct. pack or larger",
                                            "terms":"Rebate valid on Scotch-Brite® Scrub Dots",
                                            "current_value":"$0.75 Cash Back"]
                let JSON: [Any] = [offer]
                let data = try! JSONSerialization.data(withJSONObject: JSON)
                completion(.success(data))
            }
        }
        
        let offersService = OffersService(offersLoader: MockOffersLoader())
        let loadExpectation = expectation(description: "")
        
        //when
        offersService.load { (result) in
            switch result {
            case .success(let offers):
                XCTAssertEqual(offers.count, 1)
                loadExpectation.fulfill()
            case .error:
                XCTFail()
            }
        }
        
        //then
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    
    
}
