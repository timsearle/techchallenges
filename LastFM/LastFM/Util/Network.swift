//
//  Network.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import Foundation
import Base

typealias Result = Base.Result
typealias Network = Base.Network.Webservices
typealias Webservice = Base.Webservice

enum BaseURL {
    case lastfm
    
    func url() -> URL {
        switch self {
        case .lastfm:
            return URL(string: "http://ws.audioscrobbler.com/2.0")!
        }
    }
}

enum LastFMEndpoint {
    case artistSearch(String)
    
    func defaultQueryItems() -> [URLQueryItem] {
        switch self {
        case .artistSearch(let term):
            
            let method = URLQueryItem(name: "method", value: "artist.search")
            let artist = URLQueryItem(name: "artist", value: term)
            
            return [method,artist]
        }
    }
}

extension Network {
    static func load(from baseURL: BaseURL) -> Webservice {
        return Network.baseURL(baseURL.url().absoluteString)
    }
}
