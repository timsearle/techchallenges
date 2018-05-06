//
//  LastFMAPIBehaviourTests.swift
//  LastFMTests
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

@testable import LastFM

import XCTest

final class LastFMAPIBehaviourTests: XCTestCase {
    
    func testLastFMAPIBehaviour() {
        
        let urlRequest = URLRequest(url: URL(string: "http://www.google.co.uk)")!)
        
        let behaviour = LastFMAPIBehaviour(apiKey: "test", format: "json")
        
        let modified = behaviour.modify(planned: urlRequest)
        
        let urlComponents = URLComponents(url: modified.url!, resolvingAgainstBaseURL: false)
        
        var matchedCount = 0
        
        XCTAssertEqual((urlComponents?.queryItems ?? []).count, 2)
        
        for queryItem in urlComponents?.queryItems ?? [] {
            if queryItem.name == "api_key" && queryItem.value == "test" {
                matchedCount += 1
            } else if queryItem.name == "format" && queryItem.value == "json" {
                matchedCount += 1
            }
        }
        
        XCTAssertEqual(matchedCount, 2)
    }
}
