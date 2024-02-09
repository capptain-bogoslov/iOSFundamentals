//
//  MovieDetailsViewModel.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 10/2/24.
//

import Foundation
import SwiftUI

class MovieDetailsViewModel: ObservableObject {
    
    var id: Int
    
    var service: NetworkServiceProtocol
    @Published var movieDetail: MovieDetailResponse? = nil

    
    init(id: Int, service: NetworkServiceProtocol) {
        self.id = id
        self.service = service
        Task {
            await getMovieDetail(id: id)
        }
    }
    
    
    //get movie details
    func getMovieDetail(id: Int) async {
        self.movieDetail = await service.getMovieDetail()
        
    }
    
    
}
