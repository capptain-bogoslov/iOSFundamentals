//
//  NetworkService.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getMovies(page: Int, query: String?) async -> MoviesResponse?
    func getImage(from url: URL) async throws -> Data
    func getMovieDetail(id: Int) async -> MovieDetailResponse?
    func getMovieReviews(id: Int) async -> MovieReviewsResponse?
    func getSimilarMoview(id: Int) async -> [Movie]?
}

//create mock service
class MockNetworkService: NetworkServiceProtocol {
   
    //get list of movies
    func getMovies(page: Int = 1, query: String? = nil) async -> MoviesResponse? {
        guard let mockData = Bundle.main.path(forResource: "movies", ofType: "json") else { return nil }
        do {
            guard let jsonData = try String(contentsOfFile: mockData).data(using: .utf8) else { return nil }
            let response = try JSONDecoder().decode(MoviesResponse.self, from: jsonData)
            return response
        } catch {
            print(error)
            return nil
        }
    }
    
    //get Movie Detail
    func getMovieDetail(id: Int) async -> MovieDetailResponse? {
        var movie: MovieDetailResponse? = nil
        guard let mockData = Bundle.main.path(forResource: "movieDetail", ofType: "json") else { return nil }
        do {
            guard let jsonData = try String(contentsOfFile: mockData).data(using: .utf8) else { return nil }
            let response = try JSONDecoder().decode(MovieDetailResponse.self, from: jsonData)
            movie = response
        } catch {
            print(error)
            return nil
        }
        return movie
    }
    
    
    //download image
    func getImage(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func getMovieReviews(id: Int) async -> MovieReviewsResponse? {
        return nil
    }
    
    func getSimilarMoview(id: Int) async -> [Movie]? {
        return nil
    }
}


//class that implements the Network Service and downloads data from API
class NetworkAPIService: NetworkServiceProtocol {
    func getMovies(page: Int = 1, query: String? = nil) async -> MoviesResponse? {
        //define url string if we want all movies or those defined in query
        var urlString = ""
        if let validQuery = query, !validQuery.isEmpty {
            urlString = MoviesURL.searchMovies(query: validQuery, page: page).url
        } else {
            urlString = MoviesURL.moviesList(page: page).url
        }
        //fetch data from API
        guard let url = URL(string: urlString) else {
            print("Invalid url error")
            return nil
        }
        //create session
        let session = URLSession.shared
        //create request
        let request = URLRequest(url: url)
        
        do {
            //fetch data
            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid network response")
                return nil
            }
            let decodedData = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return decodedData
            
        } catch {
            print("Network request failed")
            return nil
        }
    }
    
    //download image
    func getImage(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    //download movie Detail from API
    func getMovieDetail(id: Int) async -> MovieDetailResponse? {
        //fetch data from API
        guard let url = URL(string: MoviesURL.movieDetails(id: id).url) else {
            print("Invalid url error")
            return nil
        }
        //create session
        let session = URLSession.shared
        //create request
        let request = URLRequest(url: url)
        
        do {
            //fetch data
            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid network response")
                return nil
            }
            
            let decodedData = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
            return decodedData
            
            
        } catch {
            print("Network request failed")
            return nil
        } 
    }
    
    //download Reviews for a Movie
    func getMovieReviews(id: Int) async -> MovieReviewsResponse? {
        
        guard let url = URL(string: MoviesURL.reviews(id: id).url) else { return nil}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid network response for movie reviews")
                return nil
            }
            let reviewsData = try JSONDecoder().decode(MovieReviewsResponse.self, from: data)
            return reviewsData
        } catch {
            print("Invalid network response for movie reviews")
            return nil
        }
    }
    
    //download similar movies for a Movie
    func getSimilarMoview(id: Int) async -> [Movie]? {
        guard let url = URL(string: MoviesURL.similar(id: id).url) else { return nil }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid network response for similar movies")
                return nil
            }
            let similarMoviesData = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return similarMoviesData.results
        } catch {
            print("Invalid network response for similar movies")
            return nil
        }
    }
    
    
}
