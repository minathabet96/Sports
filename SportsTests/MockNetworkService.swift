//
//  MockNetworkService.swift
//  SportsTests
//
//  Created by Mina on 15/05/2024.
//

import Foundation
@testable import Sports
class MockNetworkService {
    var shouldReturnError : Bool
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let fakeJsonData : [String : Any] =
    ["result":
        ["leagueName":"league1","leagueLogo":"logo","leagueID":1234]
    ]
    
    enum APIResponse: Error {
        case ResponseError
    }
    func fetchDataFromJson(completionHandler: @escaping(Leagues?, Error?) -> Void) {
        var result = Leagues()
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJsonData)
            result = try JSONDecoder().decode(Leagues.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        if shouldReturnError {
            completionHandler(nil, APIResponse.ResponseError)
        }
        else {
            completionHandler(result, nil)
        }
    }
}
