//
//  MoviesViewModel.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation
import UIKit

class MoviesViewModel {
    
    var service: NetworkServiceProtocol
    
    var movies: [Movie] = []
    
    var page: Int = 0
    
    var totalPages: Int = 0
    
    var totalResults: Int = 0
    
    init(service: NetworkServiceProtocol) {
        self.service = service

    }
    
    //get all movies from service
    func getMovies(page: Int = 1, query: String? = nil) async -> [Movie] {
        
        guard let data =  await service.getMovies(page: page, query: query) else {
            return []
        }
        self.movies = data.results
        self.page = data.page
        self.totalPages = data.totalPages
        self.totalResults = data.totalResults
        return movies
    }
    
    
    //get Movie Image
    func getMovieImage(from url: URL?) async -> UIImage? {
        guard let url = url else { return nil }
        do {
            let data = try await service.getImage(from: url)
            return UIImage(data: data)
        } catch {
            print("error \(error) in fetching image")
            return nil
        }
    }
    
    //add Image to favourites
    func addRemoveImageToFavourites(id: Int) {
        
        var array = UserDefaults.standard.array(forKey: "myFavouriteMovies") as? [Int] ?? []
        if array.contains(id) {
            array.removeAll { $0 == id }
        } else {
            array.append(id)
        }
        UserDefaults.standard.set(array, forKey: "myFavouriteMovies")

    }
    
    //check if Image is favourite
    func isImageFavourite(with id: Int) -> Bool {
        if let array = UserDefaults.standard.array(forKey: "myFavouriteMovies") as? [Int] {
            return array.contains(id)
        } else {
            return false
        }
    }
    
}
