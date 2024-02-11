//
//  DetailSectionView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 9/2/24.
//

import Foundation
import SwiftUI

enum DetailType {
    case runtime
    case description
    case cast
    case reviews
    case similarMovies
    
    var title: String {
        switch self {
            
        case .runtime:
            return "Runtime"
        case .description:
            return "Description"
        case .cast:
            return "Cast"
        case .reviews:
            return "Reviews"
        case .similarMovies:
            return "Similar Movies"
        }
    }
    
    var descriptionColor: Color {
        switch self {
        case .runtime:
            return .red
        case .description:
            return .gray
        case .cast, .similarMovies:
            return .black
        case .reviews:
            return .yellow
        }
    }
}

struct DetailSectionView: View {
    
    var type: DetailType
    var description: String
    var reviews: [(String, String)] = []
    var similarMovies: [UIImage] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(type.title)
                .font(.system(size: 18, weight: .bold))
            
            switch type {
            case .runtime, .description, .cast:
                Text(description)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(type.descriptionColor)
            case .reviews:
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(reviews, id: \.0) { review in
                            Text(review.0)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(type.descriptionColor)
                            Text(review.1)
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                }
            case .similarMovies:
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(similarMovies, id: \.self) { movie in
                            Image(uiImage: movie)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .frame(height: 100)
                        }
                    }
                }
            }
        }
    }
}
