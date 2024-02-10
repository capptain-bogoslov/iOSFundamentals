//
//  NetworkService.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getMovies(page: Int) async -> MoviesResponse?
    func getImage(from url: URL) async throws -> Data
    func getMovieDetail(id: Int) async -> MovieDetailResponse?
}

//create mock service
class MockNetworkService: NetworkServiceProtocol {
   
    //get list of movies
    func getMovies(page: Int = 1) async -> MoviesResponse? {
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
}

class NetworkAPIService: NetworkServiceProtocol {
    func getMovies(page: Int = 1) async -> MoviesResponse? {
        //fetch data from API
        guard let url = URL(string: MoviesURL.moviesList(page: 1).url) else {
            print("Invalid url error")
            return nil
        }
        //create session
        let session = URLSession.shared
        //create request
        var request = URLRequest(url: url)
 
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
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
        var request = URLRequest(url: url)
 
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
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
    
}
