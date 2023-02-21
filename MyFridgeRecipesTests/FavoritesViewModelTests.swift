//
//  FavoritesViewModelTests.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 20/02/2023.
//

import XCTest
import Alamofire
@testable import MyFridgeRecipes

final class FavoritesViewModelTests: XCTestCase {
    
    var mockCDManager: MockCDManager!
    var mockCDRecipesRepository: CDRecipesRepository!
    var favoritesViewModel: FavoritesViewModel!
    var recipes: Recipes!
    var recipe: Recipe!
    let label = "Boulangere Potatoes"
    
    override func setUp() {
        super.setUp()
        // Given a success fetch with a certain data
        recipes = MockData.previewRecipes
        recipe = MockData.previewSingleRecipe
        // Setup MockCDManager
        mockCDManager = MockCDManager()
        mockCDRecipesRepository = CDRecipesRepository(cdManager: mockCDManager)
        favoritesViewModel = FavoritesViewModel(repository: mockCDRecipesRepository)
        // Update Mock CoreData
        try! mockCDRecipesRepository.removeAllFavoriteRecipes()
        try! mockCDRecipesRepository.addFavoriteRecipes(recipe: recipe)
    }
    
    override func tearDown() {
        favoritesViewModel = nil
        super.tearDown()
    }
    
    // MARK: - fetchRecipeSearch Function
    func test_updateFavoriteRecipes_success() {
        // When start fetch
        favoritesViewModel.updateFavoriteRecipes()
        
        switch favoritesViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(label, recipes[0].label)
        }
    }
    
    // MARK: - getFilteredRecipes
    func test_getFilteredRecipes_success() {
        // When start fetch
        favoritesViewModel.getFilteredRecipes(searchText: "Pot")
        
        switch favoritesViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(1, recipes.count)
                XCTAssertEqual(label, recipes[0].label)
        }
    }
    
    func test_getFilteredRecipes_noRecipe() {
        // When start fetch
        favoritesViewModel.getFilteredRecipes(searchText: "Test")
        
        switch favoritesViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(0, recipes.count)
        }
    }

}
