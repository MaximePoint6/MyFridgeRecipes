//
//  RecipeDetailsViewModelTests.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 21/02/2023.
//

import XCTest
import Alamofire
@testable import MyFridgeRecipes

final class RecipeDetailsViewModelTests: XCTestCase {
    
    var mockCDManager: MockCDManager!
    var mockCDRecipesRepository: CDRecipesRepository!
    var recipeDetailsViewModel: RecipeDetailsViewModel!
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
        recipeDetailsViewModel = RecipeDetailsViewModel(recipe: recipe, repository: mockCDRecipesRepository)
        // Update Mock CoreData
        try! mockCDRecipesRepository.removeAllFavoriteRecipes()
    }
    
    override func tearDown() {
        recipeDetailsViewModel = nil
        super.tearDown()
    }
    
    // MARK: - deleteIngredient function
    func test_clickedOnIsfavorite_removeFavorite() {
        try! mockCDRecipesRepository.addFavoriteRecipes(recipe: recipe)
        recipeDetailsViewModel.checkIfIsfavorite()
        recipeDetailsViewModel.clickedOnIsfavorite()
        XCTAssertEqual(recipeDetailsViewModel.recipe.isFavorite, false)
    }
    
    func test_clickedOnIsfavorite_addFavorite() {
        recipeDetailsViewModel.clickedOnIsfavorite()
        XCTAssertEqual(recipeDetailsViewModel.recipe.isFavorite, true)
    }
    
    // MARK: - checkIfIsfavorite
    func test_checkIfIsfavorite_isFavorite() {
        try! mockCDRecipesRepository.addFavoriteRecipes(recipe: recipe)
        recipeDetailsViewModel.checkIfIsfavorite()
        XCTAssertEqual(recipeDetailsViewModel.recipe.isFavorite, true)
    }
    
    func test_checkIfIsfavorite_isNotFavorite() {
        recipeDetailsViewModel.checkIfIsfavorite()
        XCTAssertEqual(recipeDetailsViewModel.recipe.isFavorite, false)
    }
}
