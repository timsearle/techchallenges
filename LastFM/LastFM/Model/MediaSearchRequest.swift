//
//  MediaSearchRequest.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import Foundation
import Base

protocol MediaSearchRequest {
    
    associatedtype ResourceType
    
    var term: String { get }
    
    func isValidTerm() -> Bool
    func all() -> Resource<ResourceType>
}

extension MediaSearchRequest {
    
    func isValidTerm() -> Bool {
        return term.count > 2
    }
}

struct ArtistSearchRequest: MediaSearchRequest {
    
    let term: String
    
    func all() -> Resource<[Artist]> {
        
        return Resource(endpoint: "", query: LastFMEndpoint.artistSearch(term).defaultQueryItems(), parse: { (data) -> (Result<[Artist]>) in
            do {
                let artists = try JSONDecoder().decode(ArtistSearchResults.self, from: data)
                return .success(artists.results.artistmatches.artist)
            } catch {
                print(error)
                return .error(error)
            }
        })
    }
}
