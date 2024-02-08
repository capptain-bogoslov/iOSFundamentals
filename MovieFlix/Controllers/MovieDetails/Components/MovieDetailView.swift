//
//  MovieDetailView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 8/2/24.
//

import SwiftUI

struct MovieDetailView: View {
    var body: some View {
        ZStack {
            ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    Image("demoImage")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Button(action: {
                        
                    }, label: {
                        Image("share")
                    })
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 300)
                
                Group {
                    //Title-Genre-Favourite
                    HStack {
                        VStack(alignment: .leading) {
                            Text("The Light Warrior")
                                .font(.system(size: 32, weight: .bold))
                            
                            Text("Action, Adventure")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.gray)
                            
                        }
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image("Heart_g")
                            
                        })
                    }
                    
                    //Date and Rating
                    VStack(alignment: .leading) {
                        Text("15 March 2024")
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
                    
                    DetailSectionView(type: .runtime, description: "2h 28m")
                    
                    DetailSectionView(type: .description, description: "A man tries to find a lost treasure, buried deep inside the Amazon joungle")
                    
                    DetailSectionView(type: .cast, description: "Keeanu Reeves, LeBron James, Cameron Diaz")
                    
                    DetailSectionView(type: .reviews, description: "", reviews: ["Alexandra" : "I had a great laugh. What a good movie. I wonder how not everybody seen it yet", "Anna" : "Lol, boring. I wanted to sleep", "Irini" : "Not that anything that this is going to happen", "Stefania" : "Best time ever"])
                        .frame(height: 200)
                    
                    DetailSectionView(type: .similarMovies, description: "", similarMovies: ["1984", "1984", "1984", "1984", "1984", "1984"])
                        .padding(.bottom, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 15)
            }
        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MovieDetailView()
}
