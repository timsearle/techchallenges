//
//  LastFMEndpointUnitTests.swift
//  LastFMTests
//
//  Created by Tim Searle on 03/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

@testable import LastFM

import XCTest

final class LastFMEndpointUnitTests: XCTestCase {
    
    func testArtistSearchEndpoint() {
        let term = "tim"
        let endpoint = LastFMEndpoint.artistSearch(term)
        
        var matchedCount = 0
        
        for queryItem in endpoint.defaultQueryItems() {
            if queryItem.name == "method" && queryItem.value == "artist.search" {
                matchedCount += 1
            } else if queryItem.name == "artist" && queryItem.value == term {
                matchedCount += 1
            }
        }
        
        XCTAssertEqual(matchedCount, 2)
    }
}
