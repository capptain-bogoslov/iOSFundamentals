//
//  DataModel.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation
import UIKit

//Data and response from Movies List API
struct MoviesResponse: Codable {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.results = try container.decode([Movie].self, forKey: .results)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct Movie: Codable {
    var id: Int
    var title: String?
    var image: String?
    var releaseDate: String?
    var rating: CGFloat?
    var poster: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.rating = try container.decode(CGFloat.self, forKey: .rating)
        self.poster = try container.decodeIfPresent(String.self, forKey: .poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case image = "backdrop_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case poster = "poster_path"
    }
}

//Data and response from Movie Detail API
struct Genre: Codable {
    var id: Int
    var name: String
}

struct Credits: Codable {
    var cast: [Actor]
}

struct Actor: Codable {
    var name: String
}

struct MovieDetailResponse: Codable {
    var id: Int
    var title: String
    var genres: [Genre]
    var rating: CGFloat
    var releaseDate: String
    var runtime: Int
    var description: String
    var credits: Credits
    var homepage: String
    var imagePath: String?
    
    //format the date in the desired format when received from API
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        //pass the date form from the API
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //transform it to date
        guard let date = dateFormatter.date(from: releaseDate) else { return nil }
        //format to desired date format
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.rating = try container.decode(CGFloat.self, forKey: .rating)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.runtime = try container.decode(Int.self, forKey: .runtime)
        self.description = try container.decode(String.self, forKey: .description)
        self.credits = try container.decode(Credits.self, forKey: .credits)
        self.homepage = try container.decode(String.self, forKey: .homepage)
        self.imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case genres
        case rating = "vote_average"
        case releaseDate = "release_date"
        case runtime
        case description = "overview"
        case credits
        case homepage
        case imagePath = "backdrop_path"
    }
}


//Data and response from Movie Reviews API
struct MovieReviewsResponse: Codable {
    var id: Int
    var results: [Review]
}

struct Review: Codable {
    var author: String
    var content: String
}
