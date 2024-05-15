//
//  MockTest.swift
//  SportsTests
//
//  Created by Mina on 15/05/2024.
//

import XCTest

final class MockTest: XCTestCase {
    var mockNetworkService: MockNetworkService!
    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
    }
    
    func testMock() {
        mockNetworkService.fetchDataFromJson { data, error in
            if error != nil {
                XCTFail()
            }
            else {
                XCTAssertNotNil(data)
            }
        }
    }
}
