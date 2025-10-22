//
//  HomeView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var myAppManager: MyAppManager
    @StateObject private var viewModel = MovieViewModel()
    @Binding var path: [Movie]
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            Color(red: 15/255, green: 15/255, blue: 25/255).ignoresSafeArea()
            
            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                    .onChange(of: viewModel.searchText) { _, newValue in
                        Task {
                            if !newValue.isEmpty, newValue.count > 3 {
                                await viewModel.fetchMovies(query: newValue)
                            }
                            else {
                                await viewModel.fetchMovies()
                            }
                        }
                    }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.movies) { movie in
                            CardItemsView(movie: movie,
                                          selectedLanguage: myAppManager.selectedLanguage,
                                          action: {self.path.append(movie)})
                            .onAppear {
                                if movie.id == viewModel.movies.last?.id && viewModel.currentPage < viewModel.totalPages {
                                    Task {
                                        await viewModel.fetchMovies(query: viewModel.searchText, page: viewModel.currentPage + 1)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationDestination(for: Movie.self) { movie in
                    DetailView(movie: movie)
        }
        .task {
            await viewModel.fetchMovies()
        }
        .refreshable {
            await viewModel.fetchMovies()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    myAppManager.selectedLanguage =  myAppManager.selectedLanguage == "es-ES" ? "en-US" : "es-ES"
                    Task {
                        await viewModel.fetchMovies()
                    }
                }) {
                    Text(myAppManager.selectedLanguage == "es-ES" ? "ES" : "EN")
                        .fontWeight(.bold)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("home_title")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}


#Preview {
    HomeView(path: .constant([]))
}
