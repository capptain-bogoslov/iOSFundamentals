//
//  MoviesListViewController.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 7/2/24.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    private var contentView = MoviesListView()
    
    let viewModel: MoviesViewModel = MoviesViewModel(service: NetworkAPIService())
    
    var movies: [Movie] = []
    
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
        
        setUpNavigationBar()
        
        //get movie data & update table
        Task {
            self.movies = await viewModel.getMovies()
            self.contentView.tableView.reloadData()
        }
    }
    
    func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        UINavigationBar.appearance().tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as? GeneriTableViewCell<MovieView> else { return UITableViewCell() }
            //check for index out of bounds
            guard movies.count > indexPath.row else {
                return UITableViewCell()
            }
            let movie = movies[indexPath.row]
            cell.view.config(title: movie.title, rating: 0.0, releaseDate: movie.releaseDate, isFavourite: viewModel.isImageFavourite(with: movie.id), imageString: movie.image, service: self.viewModel.service)
            cell.view.favouriteTapped = { [weak self] in
                self?.viewModel.addRemoveImageToFavourites(id: movie.id)
                self?.contentView.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard movies.count > indexPath.row else { return }

        let movieDetails = MovieDetailsViewController()
        
        movieDetails.movieId = movies[indexPath.row].id
        movieDetails.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(movieDetails, animated: true)
    }
    
}



