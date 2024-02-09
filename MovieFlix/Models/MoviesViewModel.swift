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
    
}
