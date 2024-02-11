//
//  MovieDetailsViewController.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 8/2/24.
//

import Foundation
import UIKit
import SwiftUI

class MovieDetailsViewController: UIViewController {
    
    var movieId: Int = 0
    
    var isMovieFavourite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        let vc = UIHostingController(rootView:
                                        MovieDetailView(
                                            isFavourite: isMovieFavourite)
                                            .environmentObject(MovieDetailsViewModel(id: movieId, service: NetworkAPIService()))
                                            )
        guard let movieDetailView = vc.view else { return }
        movieDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(vc)
        view.addSubview(movieDetailView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            movieDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        vc.didMove(toParent: self)
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
