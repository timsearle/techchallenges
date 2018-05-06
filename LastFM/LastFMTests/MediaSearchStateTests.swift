//
//  MediaSearchStateTests.swift
//  LastFMTests
//
//  Created by Tim Searle on 03/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

@testable import LastFM

import Base
import XCTest

final class MediaSearchStateTests: XCTestCase {
    
    func testArtistInfoCopy() {
        
        let artistViewModel = ArtistSearchViewModel()
        
        let initial = MediaSearchState.initial
        let data = MediaSearchState.data([Artist(name: "", listeners: "", url: "", image: [])])
        let emptyData = MediaSearchState.data([])
        
        let sampleError = NAError(type: NetworkError.authenticationError)
        let sampleNetworkError = NAError(type: NetworkError.noConnection(1009, ""))
        
        let unknownError = MediaSearchState.error(sampleError)
        let networkError = MediaSearchState.error(sampleNetworkError)
        
        let label = UILabel()
        
        artistViewModel.configureInfoCopy(for: initial, on: label)
        XCTAssertEqual(label.text, "Please enter an artist to search for")
        XCTAssertEqual(label.isHidden, false)
        
        artistViewModel.configureInfoCopy(for: data, on: label)
        XCTAssertEqual(label.text, "")
        XCTAssertEqual(label.isHidden, true)
        
        artistViewModel.configureInfoCopy(for: emptyData, on: label)
        XCTAssertEqual(label.text, "No results found")
        XCTAssertEqual(label.isHidden, false)
        
        artistViewModel.configureInfoCopy(for: unknownError, on: label)
        XCTAssertEqual(label.text, "Something went wrong. Please try again.")
        XCTAssertEqual(label.isHidden, false)
        
        artistViewModel.configureInfoCopy(for: networkError, on: label)
        XCTAssertEqual(label.text, "Please check your internet connection")
        XCTAssertEqual(label.isHidden, false)
    }
}
