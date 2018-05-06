//
//  CustomContentTableViewCell.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import UIKit

final class CustomContentTableViewCell<ContentViewType: UIView>: UITableViewCell {

    weak var customContentView: ContentViewType? {
        didSet {
            self.subviews.forEach { $0.removeFromSuperview() }
            
            if let customContentView = customContentView {
                self.addSubview(customContentView)
                customContentView.frame = self.bounds
            }
        }
    }
}
