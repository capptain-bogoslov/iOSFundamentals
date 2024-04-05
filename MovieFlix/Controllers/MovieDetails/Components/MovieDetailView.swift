//
//  MovieDetailView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 8/2/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @EnvironmentObject var model: MovieDetailsViewModel
    @State var movie: MovieDetailResponse?
    @State var imageData: Data?
    var rating: Int {
        model.rating
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
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
                                .foregroundColor(.black)
                            
                            Text(model.genresConcatenated)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.gray)
                            
                        }
                        Spacer()
                    }
                    
                    //Date and Rating
                    VStack(alignment: .leading) {
                        Text(model.releaseDate)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.orange)
                        
                        HStack {
                            ForEach(0..<5, id:\.self) { index in
                                Image(systemName: (index + 1) <= rating ? "star.fill" : "star")
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
    }
    
    func openShareSheet(url: String) {
        
        guard let url = URL(string: url) else { return }
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true)
    }
}

