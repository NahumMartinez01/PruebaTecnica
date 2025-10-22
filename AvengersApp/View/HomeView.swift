//
//  HomeView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var selectedLanguage = "es-ES"
    @State private var searchText = ""
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText)
                .onChange(of: searchText) { _, newValue in
                    Task {
                        if !newValue.isEmpty {
                            await viewModel.fetchMovies(language: selectedLanguage, query: newValue)
                        }
                        else {
                            await viewModel.fetchMovies(language: selectedLanguage)
                        }
                    }
                }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.movies) { movie in
                        CardItemsView(movie: movie, selectedLanguage: selectedLanguage)
                            .onAppear {
                                if movie.id == viewModel.movies.last?.id && viewModel.currentPage < viewModel.totalPages {
                                    Task {
                                        await viewModel.fetchMovies(language: selectedLanguage, query: searchText, page: viewModel.currentPage + 1)
                                    }
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.fetchMovies(language: selectedLanguage)
        }
        .refreshable {
            await viewModel.fetchMovies(language: selectedLanguage)
        }
        .navigationTitle("home_title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    selectedLanguage = selectedLanguage == "es-ES" ? "en-US" : "es-ES"
                    Task {
                        await viewModel.fetchMovies(language: selectedLanguage)
                    }
                }) {
                    Text(selectedLanguage == "es-ES" ? "ES" : "EN")
                        .fontWeight(.bold)
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
