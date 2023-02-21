//
//  CDRecipesRepository.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 21/02/2023.
//

import XCTest
import Alamofire
import Mocker
@testable import MyFridgeRecipes

final class CDRecipesRepositoryTests: XCTestCase {
    
    var mockCDManager: MockCDManager!
    var cdRecipesRepository: CDRecipesRepository!
    var recipes: Recipes!
    var recipe: Recipe!
    let label = "Boulangere Potatoes"
    
    override func setUp() {
        super.setUp()
        // Given a success fetch with a certain data
        recipes = MockData.previewRecipes
        recipe = MockData.previewSingleRecipe
        // Setup MockCDManager and repository
        mockCDManager = MockCDManager()
        cdRecipesRepository = CDRecipesRepository(cdManager: mockCDManager)
        // Update Mock CoreData
        try! cdRecipesRepository.removeAllFavoriteRecipes()
    }
    
    override func tearDown() {
        cdRecipesRepository = nil
        super.tearDown()
    }
    
    // MARK: - getFavoriteRecipes & addFavoriteRecipes
    func test_getFavoriteRecipes_success_nofavorite() {
        let expectation = self.expectation(description: "Request should succeed")
        cdRecipesRepository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    XCTAssertEqual(0, response.count)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request should not fail. Error : \(error)")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func test_getFavoriteRecipes_success_withFavorites() {
        try! cdRecipesRepository.addFavoriteRecipes(recipe: recipe)
        let expectation = self.expectation(description: "Request should succeed")
        cdRecipesRepository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    XCTAssertEqual(1, response.count)
                    XCTAssertEqual(label, response[0].label)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request should not fail. Error : \(error)")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
// MARK: - removeFavoriteRecipe
    func test_removeFavoriteRecipe_success() {
        try! cdRecipesRepository.addFavoriteRecipes(recipe: recipe)
        try! cdRecipesRepository.removeFavoriteRecipe(recipe: recipe)
        let expectation = self.expectation(description: "Request should succeed")
        cdRecipesRepository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    XCTAssertEqual(0, response.count)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request should not fail. Error : \(error)")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - removeAllFavoriteRecipes
    func test_removeAllFavoriteRecipes_success() {
        // add 2 recipes
        try! cdRecipesRepository.addFavoriteRecipes(recipe: recipe)
        try! cdRecipesRepository.addFavoriteRecipes(recipe: recipe)
        // remove all
        try! cdRecipesRepository.removeAllFavoriteRecipes()
        let expectation = self.expectation(description: "Request should succeed")
        cdRecipesRepository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    XCTAssertEqual(0, response.count)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request should not fail. Error : \(error)")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - editFavoriteRecipes
    func test_editFavoriteRecipes_success() {
        // add 2 recipes
        try! cdRecipesRepository.addFavoriteRecipes(recipe: recipe)
        // edit recipe
        recipe.isFavorite = false
        try! cdRecipesRepository.editFavoriteRecipes(recipe: recipe)
        let expectation = self.expectation(description: "Request should succeed")
        cdRecipesRepository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    XCTAssertEqual(1, response.count)
                    XCTAssertEqual(false, response[0].isFavorite)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request should not fail. Error : \(error)")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
}

