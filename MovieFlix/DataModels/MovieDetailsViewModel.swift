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
    @Published var imageData: Data? = nil
    @Published var reviewsData: [(String, String)] = []
    @Published var similarMovies: [UIImage] = []
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
            self.imageData = await getMovieImage(path: movieDetail?.imagePath ?? "")
            self.reviewsData = await getMovieReviews(id: id)
            await getSimilarMovies(id: id)
        }
    }
    
    
    //get movie details
    func getMovieDetail(id: Int) async -> MovieDetailResponse? {
        let movieDetail = await service.getMovieDetail(id: id)
        return movieDetail
    }
    
    //get movie Image
    func getMovieImage(path: String) async -> Data? {
        guard let url = URL(string: MoviesURL.image(name: path).url) else { return nil }
        do {
            let data = try await service.getImage(from: url)
            return data
        } catch {
            print("Image data Error")
            return nil
        }
    }
    
    //add Image to favourites
    func addRemoveImageToFavourites() {
        guard let movieDetails = movieDetail else { return }
        var array = UserDefaults.standard.array(forKey: "myFavouriteMovies") as? [Int] ?? []
        if array.contains(movieDetails.id) {
            array.removeAll { $0 == movieDetails.id }
        } else {
            array.append(movieDetails.id)
        }
        UserDefaults.standard.set(array, forKey: "myFavouriteMovies")
    }
    
    //retrieve movie reviews and return the firs two values
    func getMovieReviews(id: Int) async -> [(String, String)]  {
        let movieReviews = await service.getMovieReviews(id: id)
        let firstTwoReview = movieReviews?.results.prefix(2)
        var reviewsToDisplay: [(String, String)] = []
        firstTwoReview?.forEach({ review in
            let r = (review.author, review.content)
            reviewsToDisplay.append(r)
        })
        return reviewsToDisplay
    }
    
    //retrieve similar movies and make a collection of movie images
    func getSimilarMovies(id: Int) async {
        var similarMovieImages: [UIImage] = []
        let group = DispatchGroup()
        
        let similarMovies = await service.getSimilarMoview(id: id)
        let moviesImagePath = similarMovies?.compactMap { $0.poster }
  
        moviesImagePath?.forEach({ path in
            group.enter()
            Task {
                let imageData = await self.getMovieImage(path: path)
                if let data = imageData, let image = UIImage(data: data) {
                    similarMovieImages.append(image)
                }
                group.leave()
            }
        })
        //use group to wait for all posters to finish to download
        group.notify(queue: .main) {
            self.similarMovies = similarMovieImages
        }
    }
    
}
    
    