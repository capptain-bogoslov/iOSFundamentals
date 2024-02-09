//
//  NetworkService.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getMovies() async -> [Movie]?
    func getImage(from url: URL) async throws -> Data
}

//create mock service
class MockNetworkService: NetworkServiceProtocol {
   
    func getMovies() async -> [Movie]? {
        var movies: [Movie] = []
        guard let mockData = Bundle.main.path(forResource: "movies", ofType: "json") else { return nil }
        do {
            guard let jsonData = try String(contentsOfFile: mockData).data(using: .utf8) else { return nil }
            let response = try JSONDecoder().decode(MoviesResponse.self, from: jsonData)
            movies = response.results
        } catch {
            print(error)
            return nil
        }
        return movies
    }
    
    func getImage(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
