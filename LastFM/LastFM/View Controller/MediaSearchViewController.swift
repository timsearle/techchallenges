//
//  MediaSearchViewController.swift
//  LastFM
//
//  Created by Tim Searle on 02/02/2018.
//  Copyright © 2018 Tim Searle. All rights reserved.
//

import UIKit

protocol MediaSearchViewControllerDelegate: class {
    func search(for term: String, on viewController: UIViewController, completion: @escaping ((Result<[MediaSearchResult]>) -> ()))
    func viewDetails(for result: MediaSearchResult, on viewController: UIViewController)
}

enum MediaSearchState {
    case initial
    case data([MediaSearchResult])
    case error(Error)
}

final class MediaSearchViewController<ContentType: MediaSearchViewModel>: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = viewModel.contents.rowHeight()
            viewModel.contents.registerCells(for: tableView)
        }
    }
    
    private weak var infoLabel: UILabel! {
        didSet {
            infoLabel.constrain { (view, superview) -> [NSLayoutConstraint] in
                [view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                 view.centerYAnchor.constraint(equalTo: superview.centerYAnchor)]
            }
            
            infoLabel.textAlignment = .center
        }
    }
    
    private let viewModel: ConcreteSearchViewModel<ContentType>
    private var results: [MediaSearchResult] = []
    
    weak var delegate: MediaSearchViewControllerDelegate?
    
    init(viewModel: ConcreteSearchViewModel<ContentType>) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(viewModel:)")
    }
    
    override func loadView() {
        let rootView = UIView()
        rootView.backgroundColor = UIColor.white
        
        let tableView = UITableView()
        rootView.addSubview(tableView)
        
        let infoLabel = UILabel()
        rootView.addSubview(infoLabel)
        
        self.view = rootView
        self.tableView = tableView
        self.infoLabel = infoLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.contents.title
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        updateState(.initial)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for indexPath in (tableView.indexPathsForVisibleRows ?? []) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tableView.frame = self.view.bounds
    }
    
    func updateState(_ state: MediaSearchState) {
        
        switch state {
        case .initial:
            self.results = []
            self.tableView.isHidden = true
        case .data(let results):
            self.results = results
            
            if !results.isEmpty {
                self.tableView.isHidden = false
            } else {
                self.tableView.isHidden = true
            }
            
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            
        case .error(_):
            self.tableView.isHidden = true
        }
        
        self.viewModel.contents.configureInfoCopy(for: state, on: infoLabel)
    }
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.contents.dequeueCell(for: tableView, indexPath: indexPath)
        
        viewModel.contents.configure(cell, with: results[indexPath.row])
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.viewDetails(for: results[indexPath.row], on: self)
    }
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchTerm = searchController.searchBar.text ?? ""
        
        guard !searchTerm.isEmpty else {
            self.updateState(.initial)
            return
        }
        
        delegate?.search(for: searchController.searchBar.text ?? "", on: self, completion: { [unowned self] result in
            
            switch result {
            case .success(let artists):
                self.updateState(.data(artists))
            case .error(let error):
                self.updateState(.error(error))
            }
        })
    }
}
