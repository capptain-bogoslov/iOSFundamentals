//
//  MovieDetailView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 8/2/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @EnvironmentObject var model: MovieDetailsViewModel
    @State var isFavourite: Bool
    @State var movie: MovieDetailResponse?
    @State var imageData: Data?
    @State var reviewsData: [(String, String)] = []
    @State var similarMovies: [UIImage] = []
    
    var body: some View {
        ZStack {
            ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                //Display Movie image received asynchronously or a ProgressView. AsyncImage not used because needs iOS >= 15
                ZStack {
                    if let data = self.imageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            .scaleEffect(2)
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                    }
                    
                    //show share button only if Movie contains a link for homepage
                    if let movie = movie, !movie.homepage.isEmpty {
                        Button(action: {
                            openShareSheet(url: movie.homepage)
                        }, label: {
                            Image("share")
                        })
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                    }
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 300)
                
                
                Group {
                    //Title-Genre-Favourite
                    HStack {
                        VStack(alignment: .leading) {
                            Text(movie?.title ?? "")
                                .font(.system(size: 32, weight: .bold))
                            
                            Text(model.genresConcatenated)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.gray)
                            
                        }
                        Spacer()
                        Button(action: {
                            //add image to favourites and update the View
                            self.isFavourite.toggle()
                            model.addRemoveImageToFavourites()
                        }, label: {
                            Image(isFavourite ? "Heart" : "Heart_g")
                            
                        })
                    }
                    
                    //Date and Rating
                    VStack(alignment: .leading) {
                        Text(model.releaseDate)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.orange)
                        
                        HStack {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.yellow)
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                    
                    DetailSectionView(type: .runtime, description: "\(model.runtime.0)h \(model.runtime.1) min")
                    
                    DetailSectionView(type: .description, description: movie?.description ?? "")
                    
                    DetailSectionView(type: .cast, description: model.castMembers)
                    
                    DetailSectionView(type: .reviews, description: "", reviews: model.reviewsData)
                        .frame(height: 200)
                    
                    DetailSectionView(type: .similarMovies, description: "", similarMovies: self.similarMovies)
                        .padding(.bottom, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 15)
            }
        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(model.$movieDetail) { newData in
            self.movie = newData
        }
        .onReceive(model.$imageData) { imageData in
            self.imageData = imageData
        }
        .onReceive(model.$reviewsData) { reviewData in
            self.reviewsData = reviewData
        }
        .onReceive(model.$similarMovies) { similarImages in
            self.similarMovies = similarImages
        }
    }
    
    func openShareSheet(url: String) {
        
        guard let url = URL(string: url) else { return }
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true)
    }
}

