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
        }
    }
    
    var descriptionColor: Color {
        switch self {
        case .runtime:
            return .red
        case .description:
            return .gray
        case .cast:
            return .black
        case .reviews:
            return .yellow
        }
    }
}

struct DetailSectionView: View {
    
    var type: DetailType
    var description: String
    var reviews: [String : String] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(type.title)
                .font(.system(size: 18, weight: .bold))
            
            if type == .reviews {
                ForEach(reviews.sorted(by: <), id: \.key) { author, review in
                    VStack {
                        Text(author)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(type.descriptionColor)
                        Text(review)
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                
            } else {
                Text(description)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(type.descriptionColor)
            }
        }
    }
}
