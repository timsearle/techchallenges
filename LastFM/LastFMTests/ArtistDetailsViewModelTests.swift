//
//  ArtistDetailsViewModelTests.swift
//  LastFMTests
//
//  Created by Tim Searle on 03/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

@testable import LastFM

import XCTest

final class ArtistDetailsViewModelTests: XCTestCase {
    
    func testArtistDetailsViewModel() {
        let testArtist = Artist(name: "Tim Searle", listeners: "1000000", url: "https://github.com/timsearle", image: [])
        let artistDetailsViewModel = ArtistDetailsViewModel(artist: testArtist)
        
        XCTAssertEqual(artistDetailsViewModel.title, "Tim Searle")
        XCTAssertEqual(artistDetailsViewModel.listeners.string, "1,000,000 listeners")
    }
    
    func testInvalidArtistDetailsViewModel() {
        let testArtist = Artist(name: "Tim Searle", listeners: "abcdef", url: "https://github.com/timsearle", image: [])
        let artistDetailsViewModel = ArtistDetailsViewModel(artist: testArtist)
        
        XCTAssertEqual(artistDetailsViewModel.title, "Tim Searle")
        XCTAssertEqual(artistDetailsViewModel.listeners.string, "0 listeners")
    }
}
