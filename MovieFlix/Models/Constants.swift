//
//  Constants.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation

struct Constants {
    
    struct APIkey {
        static let apiKeyAuth = "0f22c7b00c57ea967fa189dafd963076"
    }
    
}

enum MoviesURL {
    case moviesList(page: Int)
    case movieDetails(id: Int)
    case image(name: String)
    case search(query: String)
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
        case .search(query: let query):
            return "https://api.themoviedb.org/3/search/movie?query=\(query)&api_key=\(Constants.APIkey.apiKeyAuth)"
        case .reviews(id: let id):
            return "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=\(Constants.APIkey.apiKeyAuth)"
        case .similar(id: let id):
            return "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(Constants.APIkey.apiKeyAuth)"
        }
    }
}
