//
//  CardItemsView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

struct CardItemsView: View {
    let movie: Movie
    let selectedLanguage: String
    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomLeading) {
                PosterView(imageUrl: movie.posterPath ?? "")
                    .cornerRadius(8)
                    .clipped()
                
                VoteProgressCircle(voteAverage: movie.voteAverage ?? 0.0)
                    .offset(y: 20)
                    .padding(.leading, 0)
            }
            .padding(.bottom, 10)
            
            DescriptionView(title: movie.title ?? "", movieReleaseDate: movie.releaseDate ?? "", selectedLanguage: selectedLanguage)
        }
        .frame(maxHeight: 320)
    }
    
}

#Preview {
    CardItemsView(movie: Movie(id: 0, title: "", releaseDate: "", overview: "", posterPath: "", voteAverage: 0.0), selectedLanguage: "")
}
