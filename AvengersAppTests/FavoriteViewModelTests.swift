//
//  FavoriteViewModelTests.swift
//  AvengersAppTests
//
//  Created by Nahum Martinez on 22/10/25.
//

import XCTest
import CoreData
@testable import AvengersApp

final class FavoriteViewModelTests: XCTestCase {
        var viewModel: FavoriteViewModel!
        var context: NSManagedObjectContext!

        //MARK: CONFIGURACIÓN DEL TEST
        override func setUp() {
            super.setUp()
            let container = NSPersistentContainer(name: "AvengersApp")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { (desc, error) in
                if let error = error {
                    fatalError("Error cargando in-memory store: \(error)")
                }
            }
            context = container.viewContext
            viewModel = FavoriteViewModel(context: context)
        }

        override func tearDown() {
            viewModel = nil
            context = nil
            super.tearDown()
        }

    func testAddFavorite() {
        let movie = Movie(id: 99861, title: "Los Vengadores", originalTitle: "The Avengers", overview: "Cuando un enemigo inesperado surge como una gran amenaza para la seguridad mundial, Nick Fury, director de la Agencia SHIELD, decide reclutar a un equipo para salvar al mundo de un desastre casi seguro.", posterPath: "/ugX4WZJO3jEvTOerctAWJLinujo.jpg", backdropPath: "/9BBTo63ANSmhC4e6r62OJFuK2GL.jpg", releaseDate: "2012-04-25", voteAverage: 7.832, voteCount: 33581, popularity: 48.8269, genreIds: [878, 28, 12])
        XCTAssertFalse(viewModel.isFavorite(movie: movie))
        
        viewModel.toggleFavorite(movie: movie)
        
        XCTAssertTrue(viewModel.isFavorite(movie: movie))
        XCTAssertEqual(viewModel.favorites.count, 1)
    }
}
