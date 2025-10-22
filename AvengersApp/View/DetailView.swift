//
//  DetailView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 22/10/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var myAppManager: MyAppManager
    @Environment(\.dismiss) var dismiss
    @StateObject private var favoritesVM = FavoriteViewModel()
    
    let movie: Movie
    var body: some View {
        ZStack {
            Color(red: 15/255, green: 15/255, blue: 25/255).ignoresSafeArea()
            ScrollView {
                VStack {
                    PosterView(imageUrl: movie.posterPath ?? "", height: 350.0, rounded: 0)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                    
                    GeneralMovieInformationView(title: movie.title ?? "",
                                                overview: movie.overview ?? "",
                                                date: movie.releaseDate ?? "",
                                                voteAverage: movie.voteAverage ?? 0.0,
                                                selectedLanguage: myAppManager.selectedLanguage,
                                                isFavorite: favoritesVM.isFavorite(movie: movie),
                                                onToggleFavorite: {
                        favoritesVM.toggleFavorite(movie: movie)
                    })
                }
            }
            .overlay(
                Group {
                    if let message = favoritesVM.message {
                        Text(message)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .zIndex(1)
                            .padding(.bottom, 40)
                    }
                },
                alignment: .bottom
            )
            .animation(.easeInOut, value: favoritesVM.message)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top
        )
        .onAppear {
            favoritesVM.loadFavorites()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(movie.title ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    DetailView(movie: Movie(id: 0, title: "Los vengadores", originalTitle: "Los avengeres", overview: "", posterPath: "", backdropPath: "", releaseDate: "", voteAverage: 0.3, voteCount: 0, popularity: 0.1, genreIds: []))
}
