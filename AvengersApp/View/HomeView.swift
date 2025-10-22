//
//  HomeView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI
struct HomeView: View {
    @EnvironmentObject var myAppManager: MyAppManager
    @StateObject private var viewModel = MovieViewModel()
    @Binding var path: [HomeRoute]
    
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
                                await viewModel.searchMovies(query: newValue)
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
                                          action: {path.append(.detail(movie: movie))}
                            )
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
        .navigationDestination(for: HomeRoute.self) { route in
            switch route {
            case .detail(let movie):
                DetailView(movie: movie)
            case .favorites:
                FavoritesView(path: $path)
            }
        }
        .task {
            if viewModel.searchText.isEmpty {
                await viewModel.fetchMovies()
            } else {
                await viewModel.searchMovies(query: viewModel.searchText)
            }
        }
        .refreshable {
            if viewModel.searchText.isEmpty {
                await viewModel.fetchMovies()
            } else {
                await viewModel.searchMovies(query: viewModel.searchText)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    path.append(.favorites)
                }) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}


#Preview {
    HomeView(path: .constant([]))
}
