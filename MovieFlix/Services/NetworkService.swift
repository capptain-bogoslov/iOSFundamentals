//
//  NetworkService.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func getMovies(completion: @escaping (([Movie]?) -> Void))
}

//create mock service
class MockNetworkService: NetworkServiceProtocol {
   
    func getMovies(completion: @escaping (([Movie]?) -> Void)) {
        var movies: [Movie] = []
        guard let mockData = Bundle.main.path(forResource: "movies", ofType: "json") else { return }
        do {
            guard let jsonData = try String(contentsOfFile: mockData).data(using: .utf8) else { return }
            let response = try JSONDecoder().decode(MoviesResponse.self, from: jsonData)
            movies = response.results
        } catch {
            print(error)
            completion(nil)
        }
        completion(movies)
    }
    
    
}
