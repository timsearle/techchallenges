//
//  LastFMAPIBehaviour.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import Foundation
import Base

struct LastFMAPIBehaviour: RequestBehavior {
    
    let apiKey: String
    let format: String
    
    func modify(planned request: URLRequest) -> URLRequest {
        
        var request = request
        
        guard let url = request.url, let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return request
        }
        
        var queryItems = components.queryItems ?? []
        
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        let formatQuery = URLQueryItem(name: "format", value: format)
        
        queryItems.append(contentsOf: [apiKeyQuery,formatQuery])
        
        components.queryItems = queryItems
        
        guard let updatedUrl = components.url else {
            return request
        }
        
        request.url = updatedUrl
        
        return request
    }
    
    init(apiKey: String = "<redacted>", format: String = "json") {
        self.apiKey = apiKey
        self.format = format
    }
}

