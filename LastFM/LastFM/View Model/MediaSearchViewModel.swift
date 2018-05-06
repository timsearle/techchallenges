//
//  MediaSearchModel.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import UIKit
import Base
import Kingfisher

protocol MediaSearchViewModel {
    
    associatedtype ContentType: UIView
    
    var title: String { get }
    
    func registerCells(for tableView: UITableView)
    func configure(_ cell: CustomContentTableViewCell<ContentType>, with result: MediaSearchResult)
    func dequeueCell(for tableView: UITableView, indexPath: IndexPath) -> CustomContentTableViewCell<ContentType>
    func rowHeight() -> CGFloat
    func configureInfoCopy(for state: MediaSearchState, on label: UILabel)
}

extension MediaSearchViewModel {
    func rowHeight() -> CGFloat {
        return 50.0
    }
    
    func configureInfoCopy(for state: MediaSearchState, on label: UILabel) {
        
        let copy: String
        
        label.isHidden = false
        
        switch state {
        case .initial:
            copy = "Please enter an artist to search for"
        case .data(let results):
            guard results.isEmpty else {
                label.isHidden = true
                label.text = ""
                return
            }
            
            copy = "No results found"
        case .error(let error):
            
            if let error = error as? NAError<NetworkError>, case NetworkError.noConnection(_, _) = error.type {
                copy = "Please check your internet connection"
            } else {
                copy = "Something went wrong. Please try again."
            }
        }
        
        label.attributedText = NSAttributedString(string: copy, attributes: [.foregroundColor : UIColor.darkGray])
    }
}

struct ConcreteSearchViewModel<MediaSearchViewModel> {
    let contents: MediaSearchViewModel
}

struct ArtistSearchViewModel: MediaSearchViewModel {
    typealias ContentType = ArtistSearchResultView
    
    let title = "Artist Search"
    
    func registerCells(for tableView: UITableView) {
        tableView.register(CustomContentTableViewCell<ArtistSearchResultView>.self, forCellReuseIdentifier: String(describing: CustomContentTableViewCell<ArtistSearchResultView>.self))
    }
    
    func dequeueCell(for tableView: UITableView, indexPath: IndexPath) -> CustomContentTableViewCell<ArtistSearchResultView> {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: CustomContentTableViewCell<ArtistSearchResultView>.self), for: indexPath) as! CustomContentTableViewCell<ArtistSearchResultView>
    }
    
    func configure(_ cell: CustomContentTableViewCell<ArtistSearchResultView>, with result: MediaSearchResult) {
        
        if let contentView = cell.customContentView {
            contentView.titleLabel.text = result.title
            contentView.iconImageView.kf.setImage(with: result.icon,
                                                  placeholder: PlaceholderView(frame: contentView.iconImageView.bounds),
                                                  options: [.transition(.fade(0.2))])
        } else {
            let artistSearchResultView = ArtistSearchResultView.resultView()
            artistSearchResultView.titleLabel.text = result.title
            artistSearchResultView.iconImageView.kf.setImage(with: result.icon,
                                                             placeholder: PlaceholderView(frame: artistSearchResultView.iconImageView.bounds),
                                                             options: [.transition(.fade(0.2))])
            
            cell.customContentView = artistSearchResultView
        }
    }
}
