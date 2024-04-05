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
    
    var isLoadingMovies: Bool = true
    
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
        
        self.title = "MyMovies"
        
        self.contentView.tableView.delegate = self
        self.contentView.tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        self.contentView.tableView.refreshControl = refreshControl
        
        setUpNavigationBar()
                
        //get data for first page
        getNextPage()
        
        //handle scroll back to top button
        self.contentView.backToTopPressed = { [weak self] in
            self?.contentView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //update tableview when returning from Movie Detail so it can depict favourite movies
        self.contentView.tableView.reloadData()
    }
    
    //setup navigation bar color and style
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
            self.currentPage = 1
            getNextPage(page: currentPage)
            self.contentView.tableView.refreshControl?.endRefreshing()
            self.contentView.tableView.reloadData()
        }
    }
    
    //function that fetches Data for the next page and update the table view
    func getNextPage(page: Int = 1) {
        //get movie data append it to toal movies & update table
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            Task {
                let fetchedMovies = await self.viewModel.getMovies(page: page)
                self.isLoadingMovies = false
                self.movies.append(contentsOf: fetchedMovies)
                self.contentView.tableView.reloadData()
            }
//        }
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoadingMovies {
            //if is currently downloading add 5 cells for skeleton cells
            return movies.count + 5
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            
            //check if cell row is
            if isLoadingMovies, (indexPath.row + 1) > self.movies.count {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SkeletonCell", for: indexPath) as? GeneriTableViewCell<SkeletonCell> else { return UITableViewCell() }
                return cell

            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as? GeneriTableViewCell<MovieView> else { return UITableViewCell() }
            //check for index out of bounds
            guard movies.count > indexPath.row else {
                return UITableViewCell()
            }
            let movie = movies[indexPath.row]
            cell.view.config(title: movie.title ?? "", imageString: movie.image ?? "", service: self.viewModel.service)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard movies.count > indexPath.row + 1 else { return }

        let movieDetails = MovieDetailsViewController()
        //pass values to next vc
        movieDetails.movieId = movies[indexPath.row].id
        movieDetails.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(movieDetails, animated: true)
    }
    
    //receive the next page when user scrolls to the last cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //show backToTopButton
        self.contentView.backToTopButton.isHidden = indexPath.row <= 5

        //define last row
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        //check if is table is in last row and is not currently downloading data
        if indexPath.row == lastRow, !isLoadingMovies{
            //update current page - reload table view to add skeleton cells
            if currentPage <= viewModel.totalPages {
                self.currentPage += 1
                self.isLoadingMovies = true
                self.contentView.tableView.reloadData()
                getNextPage(page: currentPage)
            }
        }
    }
    
    //stop animations in skeleton loader when cell is out of sight
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let skeletonCell = cell.contentView as? SkeletonCell {
            skeletonCell.stopAnimations()
        }
    }
}



