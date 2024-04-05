//
//  MoviesListView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 7/2/24.
//
import Foundation
import UIKit

class MoviesListView: UIView {
    
    var backToTopPressed: (() -> Void)?

    private var titleLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Popular Movies"
        view.font = .systemFont(ofSize: 36, weight: .bold)
        return view
    }()
        
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GeneriTableViewCell<MovieView>.self, forCellReuseIdentifier: "MovieViewCell")
        tableView.register(GeneriTableViewCell<SkeletonCell>.self, forCellReuseIdentifier: "SkeletonCell")
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView(frame: tableView.bounds)
        tableView.backgroundView?.backgroundColor = .orange
        tableView.backgroundView?.layer.opacity = 0.2
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var backToTopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        button.backgroundColor = UIColor(named: "LightGray")
        button.tintColor = .black
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(backToTop), for: .touchUpInside)
        return button
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
        addSubview(titleLabel)
        addSubview(backToTopButton)
        
        backToTopButton.isHidden = true
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backToTopButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            backToTopButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            backToTopButton.widthAnchor.constraint(equalToConstant: 30),
            backToTopButton.heightAnchor.constraint(equalToConstant: 30)

        ])
        
    }
    
    @objc func backToTop() {
        self.backToTopPressed?()
    }
}
