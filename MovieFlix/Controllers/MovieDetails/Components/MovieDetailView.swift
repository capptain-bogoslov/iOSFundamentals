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
                            Text("Fuck My Life: An eternal journey")
                                .font(.system(size: 32, weight: .bold))
                            
                            Text("Genre description")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.gray)
                            
                        }
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image("Heart_g")
                            
                        })
                    }
                    
                    //Date
                    Text("15 March 2024")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.orange)
                    
                    
                    DetailSectionView(type: .runtime, description: "2h 28m")
                    
                    DetailSectionView(type: .description, description: "A lonely man tries to succeed in life only to find himself in a never ending battle between himself and his thoughts")
                    
                    DetailSectionView(type: .cast, description: "Theologos Batsioulas, Sonia Kougioni, Stefania Dimitriou, Sata")
                    
                    DetailSectionView(type: .reviews, description: "Theologos Batsioulas, Sonia Kougioni, Stefania Dimitriou, Sata", reviews: ["Alexandra" : "I had a great laugh. What a loser", "Anna" : "Lol, boring", "Irini" : "Uff that was close"])
                    
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
