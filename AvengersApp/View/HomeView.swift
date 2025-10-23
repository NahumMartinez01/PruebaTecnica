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
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            
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
                
                if viewModel.movies.isEmpty {
                    EmptyDataView()
                }
                else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.movies) { movie in
                                CardItemsView(movie: movie,
                                              selectedLanguage: myAppManager.selectedLanguage,
                                              action: {path.append(.detail(movie: movie))}
                                )
                                .accessibilityIdentifier("MovieCell_\(movie.id)")
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
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
            .overlay(
                Group {
                    if let errorMessage = viewModel.errorMessage {
                        ToastMessage(message: errorMessage)
                    }
                },
                alignment: .bottom
            )
            .animation(.easeInOut, value: viewModel.errorMessage)
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
                .accessibilityIdentifier("FavoritesToolbarButton")
            }
        }
    }
}


#Preview {
    HomeView(path: .constant([]))
}
