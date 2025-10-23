//
//  AvengersAppUITests.swift
//  AvengersAppTests
//
//  Created by Nahum Martinez on 22/10/25.
//

import XCTest

final class AvengersAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["-UITest"]
        app.launch()
    }
    
    override func tearDown() {
           app = nil
           super.tearDown()
       }
    
    
    
    func testAddMovieToFavoritesFlow() {
        let firstMovieCell = app.cells["MovieCell_24428"]
        XCTAssertTrue(firstMovieCell.waitForExistence(timeout: 300))

        // Ir a DetailView
        firstMovieCell.tap()

        // Verificar que el título del detalle se muestra correctamente
        let detailTitle = app.staticTexts["DetailTitle"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 300))

        // Tocar el botón de favorito
        let favoriteButton = app.buttons["FavoriteButton"]
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 2))
        favoriteButton.tap()

        // Verificar que aparece el toast
        let toast = app.staticTexts["ToastMessage"]
        XCTAssertTrue(toast.waitForExistence(timeout: 2))

        // Esperar que el toast desaparezca
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: toast
        )
        _ = XCTWaiter.wait(for: [expectation], timeout: 3)

        //  Volver a Home
        app.navigationBars.buttons.firstMatch.tap()

        // Abrir pantalla de favoritos
        let favoritesButton = app.buttons["FavoritesToolbarButton"] // Ponle accessibilityIdentifier al botón heart en HomeView
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 2))
        favoritesButton.tap()

        // Verificar que la película agregada aparece en la lista de favoritos
        let favoriteCell = app.cells["MovieCell_24428"]
        XCTAssertTrue(favoriteCell.waitForExistence(timeout: 2))
    }
}
