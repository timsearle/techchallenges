//
//  ArtistSearchCoordinator.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import UIKit
import Base

final class ArtistCoordinator: Coordinator {
    
    func searchViewController() -> MediaSearchViewController<ArtistSearchViewModel> {
        let viewModel = ConcreteSearchViewModel(contents: ArtistSearchViewModel())
        let searchViewController = MediaSearchViewController(viewModel: viewModel)
        
        searchViewController.delegate = self
        
        return searchViewController
    }
}

extension ArtistCoordinator: MediaSearchViewControllerDelegate {
    
    func search(for term: String, on viewController: UIViewController, completion: @escaping ((Result<[MediaSearchResult]>) -> ())) {
        
        let searchRequest = ArtistSearchRequest(term: term)
        
        if searchRequest.isValidTerm() {
            
            Network.load(from: .lastfm).request(searchRequest.all(), withBehavior: LastFMAPIBehaviour(), completion: { result in
                
                let typedResult: Result<[MediaSearchResult]>
                
                switch result {
                case .success(let artists):
                    typedResult = .success(artists)
                case .error(let error):
                    typedResult = .error(error)
                }
                
                completion(typedResult)
            })
        }
    }
    
    func viewDetails(for result: MediaSearchResult, on viewController: UIViewController) {
        
        guard let artist = result as? Artist else {
            return
        }
        
        let viewController = ArtistDetailsViewController.viewController(viewModel: ArtistDetailsViewModel(artist: artist))
        viewController.delegate = self
        self.pushChild(viewController: viewController, animated: true)
    }
}

extension ArtistCoordinator: ArtistsDetailsViewControllerDelegate {
    
    func loadWebsite(for artist: Artist, on viewController: ArtistDetailsViewController) {
        
        guard let url = URL(string: artist.url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
