//
//  ArtistDetailsViewController.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import UIKit

protocol ArtistsDetailsViewControllerDelegate: class {
    func loadWebsite(for artist: Artist, on viewController: ArtistDetailsViewController)
}

final class ArtistDetailsViewController: UIViewController {

    weak var delegate: ArtistsDetailsViewControllerDelegate?
    
    private var viewModel: ArtistDetailsViewModel!
    
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var listenersLabel: UILabel!
    @IBOutlet private weak var urlButton: UIButton! {
        didSet {
            urlButton.setTitle("View Website", for: .normal)
        }
    }
    
    class func viewController(viewModel: ArtistDetailsViewModel) -> ArtistDetailsViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ArtistDetailsViewController.self)) as! ArtistDetailsViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewModel.title
        self.artistImageView.kf.setImage(with: viewModel.artist.icon, placeholder: PlaceholderView(), options: [.transition(.fade(0.2))])
        self.listenersLabel.attributedText = viewModel.listeners
    }
    
    @IBAction private func didPressWebsiteButton(_ sender: Any) {
        delegate?.loadWebsite(for: viewModel.artist, on: self)
    }
}
