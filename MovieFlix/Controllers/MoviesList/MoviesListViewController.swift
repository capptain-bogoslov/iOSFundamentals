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
    
    var currentPage: Int = 1
    
    var isLoadingMovies: Bool = false
    
    //add refresh control to update the data
    let refreshControl = UIRefreshControl()
    
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
        self.contentView.searchBar.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        self.contentView.tableView.refreshControl = refreshControl
        
        setUpNavigationBar()
        
        //get data for firsta page
        getNextPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //update tableview
        self.contentView.tableView.reloadData()
    }
    
    func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        UINavigationBar.appearance().tintColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    //function that contains the logic for refreshing data
    @objc func refreshTable() {
        //get movie data & update table
        Task {
            getNextPage(page: 1)
            self.currentPage = 1
            self.contentView.tableView.refreshControl?.endRefreshing()
            self.contentView.tableView.reloadData()
        }
    }
    
    //function that fetches Data for the next page and update the table view
    func getNextPage(page: Int = 1) {
        //get movie data append it to toal movies & update table
        Task {
            let fetchedMovies = await viewModel.getMovies(page: page)
            self.movies.append(contentsOf: fetchedMovies)
            self.contentView.tableView.reloadData()
            self.isLoadingMovies = false

        }
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
            cell.view.config(title: movie.title ?? "", rating: movie.rating ?? 0.0, releaseDate: DateHandler.shared.getDate(input: movie.releaseDate) ?? "", isFavourite: viewModel.isImageFavourite(with: movie.id), imageString: movie.image ?? "", service: self.viewModel.service)
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
        //pass values to next vc
        movieDetails.movieId = movies[indexPath.row].id
        movieDetails.isMovieFavourite = viewModel.isImageFavourite(with: movies[indexPath.row].id)
        movieDetails.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(movieDetails, animated: true)
    }
    
    //receive the next page when user scrolls to the last cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //define last row
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRow, !isLoadingMovies {
            //update current page
            if currentPage <= viewModel.totalPages {
                self.currentPage += 1
                self.isLoadingMovies = true
                getNextPage(page: currentPage)
            }
        }
    }
    
}

extension MoviesListViewController: UISearchBarDelegate {
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //When user press return in search button then update table view with related movies
        Task {
            self.movies = await viewModel.getMovies(query: searchBar.text)
            searchBar.resignFirstResponder()
            self.contentView.tableView.reloadData()
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.enablesReturnKeyAutomatically = false
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Task {
            self.movies = await viewModel.getMovies()
            searchBar.resignFirstResponder()
            self.contentView.tableView.reloadData()
        }
    }
}



