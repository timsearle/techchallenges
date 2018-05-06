//
//  ArtistSearchRequestTests.swift
//  LastFMTests
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

@testable import LastFM

import XCTest

final class ArtistSearchRequestTests: XCTestCase {
    
    var artistData: Data {
        let url = Bundle(for: type(of: self)).url(forResource: "artists", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testArtistSerialization() {
        
        let artistSearchRequest = ArtistSearchRequest(term: "jan")
        
        let result = artistSearchRequest.all().parse(artistData)
        
        if case let .success(artists) = result {
            XCTAssertTrue(artists.count == 30)
            
            guard let first = artists.first else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(first.name, "Janis Joplin")
            XCTAssertEqual(first.listeners, "1364646")
            XCTAssertEqual(first.url, "https://www.last.fm/music/Janis+Joplin")
            XCTAssertEqual(first.image.first ?? [:], ["#text": "https://lastfm-img2.akamaized.net/i/u/34s/ea2e65e2465a4a00bbb9f8ab35978292.png",
                                               "size": "small"])
        } else {
            XCTFail()
        }
        
    }
    
    func testValidRequest() {
        let validArtistSearchRequest = ArtistSearchRequest(term: "jan")
        let invalidArtistSearchRequest = ArtistSearchRequest(term: "ja")
        
        XCTAssertTrue(validArtistSearchRequest.isValidTerm())
        XCTAssertFalse(invalidArtistSearchRequest.isValidTerm())
    }
    
}
