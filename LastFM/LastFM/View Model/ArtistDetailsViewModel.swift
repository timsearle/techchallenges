//
//  ArtistDetailsViewModel.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import Foundation

struct ArtistDetailsViewModel {
    
    let artist: Artist
    
    var listeners: NSAttributedString {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = Locale.current.groupingSeparator
        numberFormatter.groupingSize = 3
        
        let listenersValue = Double(artist.listeners) ?? 0
        let formattedValue = numberFormatter.string(from: NSNumber(value: listenersValue)) ?? ""
        
        return NSAttributedString(string: "\(formattedValue) listeners")
    }
    
    var title: String {
        return artist.name
    }
}
