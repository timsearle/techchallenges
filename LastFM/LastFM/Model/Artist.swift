//
//  Artist.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import Foundation

struct ArtistSearchResults: Codable {
    
    struct SearchResult: Codable {
        
        struct ArtistMatches: Codable {
            let artist: [Artist]
        }
        
        let artistmatches: ArtistMatches
    }
    
    let results: SearchResult
}

struct Artist: Codable {
    let name: String
    let listeners: String
    let url: String
    let image: [[String : String]]
}

extension Artist: MediaSearchResult {
    
    var title: String {
        return name
    }
    
    var icon: URL? {
        
        if let urlString = (image.last ?? [:])["#text"] {
            return URL(string: urlString)
        }
        
        return nil
    }
}
