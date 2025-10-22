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
    
    private var appManager: MyAppManager
    
    init() {
        appManager = MyAppManager.shared()
    }
    
    @MainActor
    func fetchMovies(query: String = "Avengers", page: Int = 1) async {
        errorMessage = nil
        self.appManager.isLoadingView = true
        
        let finalQuery = query.isEmpty ? "Avengers" : query
        
        guard var components = URLComponents(string: "https://api.themoviedb.org/3/collection/86311?language=es-ES") else {
            errorMessage = "URL inválida"
            self.appManager.isLoadingView = false
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "query", value: finalQuery),
            URLQueryItem(name: "language", value: self.appManager.selectedLanguage),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components.url else {
            errorMessage = "URL con parámetros inválida"
            self.appManager.isLoadingView = false
            return
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.timeoutInterval = 300
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3Y2NjODExMmUwOTk4YTNmMjFkMjgyNTM2ZGYyNWFhMSIsIm5iZiI6MTc2MTA4NjU2Mi44MjcwMDAxLCJzdWIiOiI2OGY4MGM2MjJiYWRlMzQ0NmM4MDU0M2UiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.qU7N59eoqvbOMGsYTeJM_thSSlj25ZD8KoHcTDcc2lU", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                errorMessage = "Error HTTP: \(httpResponse.statusCode)"
                self.appManager.isLoadingView = false
                return
            }

            let decoder = JSONDecoder()
            let datum = try decoder.decode(MovieCollectionResponse.self, from: data)
            
            for movie in datum.parts {
                print("""
                🎬 Título: \(movie.title)
                📅 Estreno: \(movie.releaseDate ?? "Sin fecha")
                📝 Descripción: \(movie.overview?.prefix(100) ?? "Sin descripción")...
                   Rate: \(movie.voteAverage ?? 10000000.00)
                -----------------------------
                """)
            }
            
            self.movies = datum.parts
            self.appManager.isLoadingView = false

        } catch {
            self.errorMessage = "Error de red: \(error.localizedDescription)"
            self.appManager.isLoadingView = false
        }
    }
    
    @MainActor
    func searchMovies(query: String, page: Int = 1) async {
        errorMessage = nil
        self.appManager.isLoadingView = true
        
        let finalQuery = query.isEmpty ? "Avengers" : query
        
        guard var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie") else {
            errorMessage = "URL inválida"
            self.appManager.isLoadingView = false
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "query", value: finalQuery),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "language", value: self.appManager.selectedLanguage),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components.url else {
            errorMessage = "URL con parámetros inválida"
            self.appManager.isLoadingView = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 300
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3Y2NjODExMmUwOTk4YTNmMjFkMjgyNTM2ZGYyNWFhMSIsIm5iZiI6MTc2MTA4NjU2Mi44MjcwMDAxLCJzdWIiOiI2OGY4MGM2MjJiYWRlMzQ0NmM4MDU0M2UiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.qU7N59eoqvbOMGsYTeJM_thSSlj25ZD8KoHcTDcc2lU",
            forHTTPHeaderField: "Authorization"
        )
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                errorMessage = "Error HTTP: \((response as? HTTPURLResponse)?.statusCode ?? -1)"
                self.appManager.isLoadingView = false
                return
            }
            
            let decoder = JSONDecoder()
            let datum = try decoder.decode(MovieSearchResponse.self, from: data)
            
            for movie in datum.results ?? [] {
                print("""
                🎬 Título: \(movie.title)
                📅 Estreno: \(movie.releaseDate ?? "Sin fecha")
                📝 Descripción: \(movie.overview?.prefix(100) ?? "Sin descripción")...
                ⭐️ Rate: \(movie.voteAverage ?? 0.0)
                -----------------------------
                """)
            }
            
            self.movies = datum.results ?? []
            self.appManager.isLoadingView = false
            
        } catch {
            self.errorMessage = "Error de red: \(error.localizedDescription)"
            self.appManager.isLoadingView = false
        }
    }

}
