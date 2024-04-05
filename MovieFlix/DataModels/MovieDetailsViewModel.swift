//
//  MovieDetailsViewModel.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 10/2/24.
//

import Foundation
import SwiftUI

@MainActor
class MovieDetailsViewModel: ObservableObject {
    
    var id: Int
    
    var service: NetworkServiceProtocol
    @Published var movieDetail: MovieDetailResponse? = nil
    //concatenate genre names
    var genresConcatenated: String {
        guard let movieDetail = movieDetail else { return ""}
        return movieDetail.genres.compactMap { $0.name }.joined(separator: ",")
    }
    //format Date
    var releaseDate: String {
        return DateHandler.shared.getDate(input: movieDetail?.releaseDate) ?? ""
    }
    //format time
    var runtime: (Int, Int) {
        let hours = (movieDetail?.runtime ?? 0) / 60
        let minutes = (movieDetail?.runtime ?? 0) % 60
        return (hours, minutes)
    }
    //format cast members
    var castMembers: String {
        guard let movieDetail = movieDetail else { return "" }
        let actors = movieDetail.credits.cast.prefix(5)
        return actors.compactMap{ $0.name }.joined(separator: ",")
    }
    var rating: Int {
        guard let movieDetail = movieDetail else { return 0 }
        return Int(movieDetail.rating / 2)
    }

    
    init(id: Int, service: NetworkServiceProtocol) {
        self.id = id
        self.service = service
        Task {
            self.movieDetail = await getMovieDetail(id: id)
        }
    }
    
    
    //get movie details
    func getMovieDetail(id: Int) async -> MovieDetailResponse? {
        let movieDetail = await service.getMovieDetail(id: id)
        return movieDetail
    }
    
}
    
    
