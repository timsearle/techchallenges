//
//  AppCoordinator.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import Foundation
import Base

final class AppCoordinator: Coordinator {
    
    func start() {
        setupNetwork()
        
        let artistSearchCoordinator = ArtistCoordinator(navigationController: self.navigationController)
        
        self.add(child: artistSearchCoordinator)
        
        let artistSearchViewController = artistSearchCoordinator.searchViewController()
        self.navigationController.pushViewController(artistSearchViewController, animated: true)
    }
    
    private func setupNetwork() {
        Network.add(baseURL: BaseURL.lastfm.url().absoluteString)
    }
}
