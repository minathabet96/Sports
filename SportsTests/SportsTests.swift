//
//  SportsTests.swift
//  SportsTests
//
//  Created by Mina on 12/05/2024.
//

import XCTest
@testable import Sports

final class SportsTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testFetchData() {
        let expectation = expectation(description: "waiting for api response")
        DataFetcher.shared.fetchData(urlString: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=00df14beddee4ef5d0efee2255fde53ef246055b52806f3c699c4d5af73704e6") { data in
            let result: Leagues = DataDecoder.shared.decode(data: data)
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}
