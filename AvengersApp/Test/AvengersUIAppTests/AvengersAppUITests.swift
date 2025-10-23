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
        // Se agrega este debug para poder observar en consola la ejecución del test 
        print(app.debugDescription)
        
        let firstMovieCell = app.otherElements["MovieCell_24428"]
        XCTAssertTrue(firstMovieCell.waitForExistence(timeout: 10))
        
        // Ir a DetailView
        firstMovieCell.tap()
        
        // Verificar que el título del detalle se muestra correctamente
        let detailTitle = app.staticTexts["DetailTitle"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 10))
        
        // Tocar el botón de favorito
        let favoriteButton = app.buttons["FavoriteButton"]
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 5))
        favoriteButton.tap()
        
        // Verificar que aparece el toast
        let toast = app.staticTexts["ToastMessage"]
        XCTAssertTrue(toast.waitForExistence(timeout: 5))
        
        // Esperar que el toast desaparezca
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: toast
        )
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Volver a Home
        app.navigationBars.buttons.firstMatch.tap()
        
        // Abrir pantalla de favoritos
        let favoritesButton = app.buttons["FavoritesToolbarButton"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        // Verificar que la película agregada aparece en la lista de favoritos
        let movieFavCell = app.otherElements["MovieFavCell_24428"]
        XCTAssertTrue(movieFavCell.waitForExistence(timeout: 10))
    }
}
