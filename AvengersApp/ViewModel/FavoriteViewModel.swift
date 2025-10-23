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
    
    init(context: NSManagedObjectContext = PersistenceController.shared.context) {
          self.context = context
          self.appManager = MyAppManager.shared()
      }
    
    //MARK: FETCH THE FAVORITES MOVIES BY CORE DATA
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
    
    // MARK: TOGGLE FAVORITE FUNCTION
    func toggleFavorite(movie: Movie) {
        if isFavorite(movie: movie) {
            removeFavorite(movie: movie)
            showMessage("\(movie.title ?? "Película") eliminada de favoritos correctamente!")
        } else {
            addFavorite(movie: movie)
            showMessage("\(movie.title ?? "Película") agregada a favoritos correctamente!")
        }
    }
    
    //MARK: GET FAVORITE MOVIES
    func isFavorite(movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }
    
    // MARK: PREPARE DATA TO SAVE IN CORE DATA
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
    
    // MARK: REMOVE TO FAVORITE MOVIES IN CORE DATA
    private func removeFavorite(movie: Movie) {
        if let existing = favoritesEntity.first(where: { $0.id == movie.id }) {
            context.delete(existing)
            save()
        }
    }
    
    // MARK: SAVE TO FAVORITE MOVIES IN CORE DATA
    private func save() {
        PersistenceController.shared.saveContext()
        loadFavorites()
    }
    
    // MARK: SHOW SUCCESS OR ERROR TOAST MESSAGE
    private func showMessage(_ text: String) {
        message = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.message = nil
        }
    }
}
