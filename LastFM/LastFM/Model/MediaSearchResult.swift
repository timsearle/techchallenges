//
//  MediaSearchResult.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import Foundation

protocol MediaSearchResult {
    var title: String { get }
    var icon: URL? { get }
}
