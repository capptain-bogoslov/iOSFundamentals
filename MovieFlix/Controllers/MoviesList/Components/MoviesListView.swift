//
//  MoviesListView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 7/2/24.
//
import Foundation
import UIKit

class MoviesListView: UIView {

        
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GeneriTableViewCell<SearchView>.self, forCellReuseIdentifier: "SearchViewCell")
        tableView.register(GeneriTableViewCell<MovieView>.self, forCellReuseIdentifier: "MovieViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        self.backgroundColor = .white
        addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
