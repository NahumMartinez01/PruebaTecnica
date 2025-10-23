//
//  MovieViewModel.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var errorMessage: String? = nil
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var searchText: String = ""
    @Published var isLoadingPage = false
    
    private var appManager: MyAppManager
    
    init() {
        appManager = MyAppManager.shared()
    }
    
    func isEmptyData() -> Bool {
        return movies.isEmpty && !self.appManager.isLoadingView
    }
    @MainActor
    func getData() async {
        guard !isLoadingPage else { return }
        isLoadingPage = true
        
        if searchText.isEmpty {
            await fetchMovies()
        } else {
            await searchMovies(query: searchText, page: currentPage + 1)
        }
        
        isLoadingPage = false
    }
    
    // MARK: FUNCTION TO GET MARVEL'S AVENGER MOVIE
    @MainActor
    func fetchMovies() async {
        errorMessage = nil
        appManager.isLoadingView = true
        
        do {
            let response: MovieCollectionResponse = try await NetworkManager.shared.request(
                path: "/collection/86311",
                queryItems: [URLQueryItem(name: "language", value: appManager.selectedLanguage)]
            )
            self.movies = response.parts
        } catch {
            self.errorMessage = (error as? NetworkManager.NetworkError)?.errorDescription ?? error.localizedDescription
        }
        
        appManager.isLoadingView = false
    }
    
    //MARK: FUNCTION TO SEARCH SPECIFIC MOVIES
    @MainActor
    func searchMovies(query: String, page: Int = 1) async {
        errorMessage = nil
        appManager.isLoadingView = true
        let finalQuery = query.isEmpty ? "Avengers" : query
        do {
            let response: MovieSearchResponse = try await NetworkManager.shared.request(
                path: "/search/movie",
                queryItems: [
                    URLQueryItem(name: "query", value: finalQuery),
                    URLQueryItem(name: "include_adult", value: "false"),
                    URLQueryItem(name: "language", value: appManager.selectedLanguage),
                    URLQueryItem(name: "page", value: "\(page)")
                ]
            )
            
            if page == 1 {
                self.movies = response.results ?? []
            } else {
                self.movies.append(contentsOf: response.results ?? [])
            }
            self.currentPage = response.page ?? 0
            self.totalPages = response.totalPages ?? 0
            
        } catch {
            self.errorMessage = (error as? NetworkManager.NetworkError)?.errorDescription ?? error.localizedDescription
        }
        
        appManager.isLoadingView = false
    }
    
}
