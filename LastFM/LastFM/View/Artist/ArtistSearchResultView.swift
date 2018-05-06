//
//  ArtistSearchResultView.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import UIKit
import Kingfisher

final class PlaceholderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.lightGray
    }
}

extension PlaceholderView: Placeholder {}


final class ArtistSearchResultView: UIView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    class func resultView() -> ArtistSearchResultView {
        return Bundle.main.loadNibNamed(String(describing: ArtistSearchResultView.self), owner: nil, options: nil)?.first as! ArtistSearchResultView
    }
}
