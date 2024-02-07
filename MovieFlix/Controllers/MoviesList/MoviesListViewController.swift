//
//  MoviesListViewController.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 7/2/24.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    private var contentView = MoviesListView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MovieFlix"
        
        self.contentView.tableView.delegate = self
        self.contentView.tableView.dataSource = self
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchViewCell", for: indexPath) as? GeneriTableViewCell<SearchView> else { return UITableViewCell() }
            
            return cell
        case (1, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as? GeneriTableViewCell<MovieView> else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}



