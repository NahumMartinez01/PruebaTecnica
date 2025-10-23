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
    let action: () -> Void
    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomLeading) {
                PosterView(imageUrl: movie.posterPath ?? "")
                    .cornerRadius(8)
                    .clipped()
                
                VoteProgressCircle(voteAverage: movie.voteAverage ?? 0.0)
                    .offset(y: 20)
                    .padding(.leading, 2)
            }
            .padding(.bottom, 10)
            
            DescriptionView(title: movie.title ?? "", movieReleaseDate: movie.releaseDate ?? "", selectedLanguage: selectedLanguage)
        }
        .frame(maxHeight: 300)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.borderCard), lineWidth: 0.5)
        )
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    CardItemsView(movie: Movie(id: 0, title: "Los vengadores", originalTitle: "Los avengeres", overview: "", posterPath: "", backdropPath: "", releaseDate: "", voteAverage: 0.3, voteCount: 0, popularity: 0.1, genreIds: []), selectedLanguage: "",action: {})
}
