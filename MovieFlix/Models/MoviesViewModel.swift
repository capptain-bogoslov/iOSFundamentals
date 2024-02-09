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
    
    init(service: NetworkServiceProtocol) {
        self.service = service

    }
    
    //get all movies from service
    func getMovies() async -> [Movie] {
        
        self.movies =  await service.getMovies() ?? []
        
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
