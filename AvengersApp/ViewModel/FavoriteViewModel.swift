//
//  FavoriteViewModel.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 22/10/25.
//

import Foundation
import CoreData

class FavoriteViewModel: ObservableObject {
    @Published var favoritesEntity: [FavoriteMovieEntity] = []
    @Published var favorites: [Movie] = []
    @Published var message: String? = nil
    
    private let context: NSManagedObjectContext
    private var appManager: MyAppManager
    
    init() {
        appManager = MyAppManager.shared()
        context = PersistenceController.shared.context
    }
    
    func loadFavorites() {
        let request: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        do {
            favoritesEntity = try context.fetch(request)
            
            favorites = favoritesEntity.map { entity in
                Movie(
                    id: Int(entity.id),
                    title: entity.title,
                    originalTitle: entity.title,
                    overview: entity.overview,
                    posterPath: entity.posterPath,
                    backdropPath: nil,
                    releaseDate: entity.releaseDate,
                    voteAverage: entity.voteAverage,
                    voteCount: nil,
                    popularity: nil,
                    genreIds: nil
                )
            }
        } catch {
            showMessage("❌ Error obteniendo los favoritos: \(error)")
        }
        
    }
    
    func toggleFavorite(movie: Movie) {
        if isFavorite(movie: movie) {
            removeFavorite(movie: movie)
            showMessage("\(movie.title ?? "Película") eliminada de favoritos correctamente!")
        } else {
            addFavorite(movie: movie)
            showMessage("\(movie.title ?? "Película") agregada a favoritos correctamente!")
        }
    }
    
    func isFavorite(movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }
    
    private func addFavorite(movie: Movie) {
        let entity = FavoriteMovieEntity(context: context)
        entity.id = Int64(movie.id)
        entity.title = movie.title
        entity.overview = movie.overview
        entity.posterPath = movie.posterPath
        entity.releaseDate = movie.releaseDate
        entity.voteAverage = movie.voteAverage ?? 0.0
        save()
    }
    
    private func removeFavorite(movie: Movie) {
        if let existing = favoritesEntity.first(where: { $0.id == movie.id }) {
            context.delete(existing)
            save()
        }
    }
    
    private func save() {
        PersistenceController.shared.saveContext()
        loadFavorites()
    }
    
    private func showMessage(_ text: String) {
        message = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.message = nil
        }
    }
    
}
