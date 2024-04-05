//
//  Constants.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation

struct Constants {
    
    struct APIkey {
        static let apiKeyAuth = "8ea485e34dc7c33484fa5882b3aaa829"
    }
    
}

enum MoviesURL {
    case moviesList(page: Int)
    case movieDetails(id: Int)
    case image(name: String)
    case searchMovies(query: String, page: Int)
    case reviews(id: Int)
    case similar(id: Int)
    
    var url: String {
        switch self {
        case .moviesList(page: let page):
            return "https://api.themoviedb.org/3/movie/popular?page=\(page)&api_key=\(Constants.APIkey.apiKeyAuth)"
        case .movieDetails(id: let id):
            return "https://api.themoviedb.org/3/movie/\(id)?append_to_response=credits&api_key=\(Constants.APIkey.apiKeyAuth)"
        case .image(name: let name):
            return "https://image.tmdb.org/t/p/w500\(name)"
        case .searchMovies(query: let query, page: let page):
            return "https://api.themoviedb.org/3/search/movie?query=\(query)&page=\(page)&api_key=\(Constants.APIkey.apiKeyAuth)"
        case .reviews(id: let id):
            return "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=\(Constants.APIkey.apiKeyAuth)"
        case .similar(id: let id):
            return "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(Constants.APIkey.apiKeyAuth)"
        }
    }
}
