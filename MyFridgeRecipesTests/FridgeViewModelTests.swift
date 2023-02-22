//
//  FridgeViewModelTests.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 19/02/2023.
//

import XCTest
import Alamofire
@testable import MyFridgeRecipes

final class FridgeViewModelTests: XCTestCase {
    
    var fridgeViewModel: FridgeViewModel!
    var mockAPIManager: MockAPIManager!
    var recipes: Recipes!
    let label = "Boulangere Potatoes"
    
    override func setUp() {
        super.setUp()
        // Given a success fetch with a certain data
        recipes = MockData.previewRecipes
        // Setup MockAPIManager
        mockAPIManager = MockAPIManager()
        fridgeViewModel = FridgeViewModel(apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        fridgeViewModel = nil
        mockAPIManager = nil
        super.tearDown()
    }
    
    // MARK: - fetchRecipeSearch Function
    func test_fetchRecipeSearchFunction_success() {
        // When start fetch
        fridgeViewModel.fetchRecipeSearch()
        mockAPIManager.fetchSuccess(result: recipes)
        
        switch fridgeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(label, recipes[0].label)
        }
    }
    
    func test_fetchRecipeSearchFunction_fail_decoding() {
        // Given a failed fetch with a certain failure
        let error = AFError.responseSerializationFailed(reason: .inputFileNil)
        // When start fetch
        fridgeViewModel.fetchRecipeSearch()
        mockAPIManager.fetchFail(error: error)
        
        switch fridgeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(ErrorManager.ErrorType.decoding, error)
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    func test_fetchRecipeSearchFunction_fail_BackEndError() {
        // Given a failed fetch with a certain failure
        let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500))
        // When start fetch
        fridgeViewModel.fetchRecipeSearch()
        mockAPIManager.fetchFail(error: error)
        
        switch fridgeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(ErrorManager.ErrorType.backend(500), error)
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    // MARK: - fetchNextRecipesWithUrl Function
    func test_fetchNextRecipesWithUrlFunction_success() {
        // For this test to work, you must fill before the private variable nextRecipesUrl of the viewModel.
        // This variable being at nil by default, we therefore launch a request simulation to fill this variable.
        fridgeViewModel.fetchRecipeSearch()
        mockAPIManager.fetchSuccess(result: recipes)
        // Reset page state for tests
        fridgeViewModel.pageState = .loading
        
        // When start fetch
        fridgeViewModel.fetchNextRecipesWithUrl()
        mockAPIManager.fetchSuccess(result: recipes)
        
        switch fridgeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(label, recipes[0].label)
        }
    }
    
    func test_fetchNextRecipesWithUrlFunction_fail() {
        // For this test to work, you must fill before the private variable nextRecipesUrl of the viewModel.
        // This variable being at nil by default, we therefore launch a request simulation to fill this variable.
        fridgeViewModel.fetchRecipeSearch()
        mockAPIManager.fetchSuccess(result: recipes)
        // Reset page state for tests
        fridgeViewModel.pageState = .loading
        
        // Given a failed fetch with a certain failure
        let error = AFError.sessionTaskFailed(error: MockResponseData.error)
        // When start fetch
        fridgeViewModel.fetchNextRecipesWithUrl()
        mockAPIManager.fetchFail(error: error)
        
        switch fridgeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(ErrorManager.ErrorType.noInternet, error)
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    // MARK: - fetchIngredientSearch Function
    func test_fetchIngredientSearchFunction_success() {
        // When start fetch
        fridgeViewModel.fetchIngredientSearch(searchText: "Tomat")
        mockAPIManager.fetchSuccess(result: ["Tomato"])

        XCTAssertEqual(fridgeViewModel.searchedIngredients, ["Tomato"])
    }
    
    func test_fetchIngredientSearch_fail_BackEndError() {
        // Given a failed fetch with a certain failure
        let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500))
        // When start fetch
        fridgeViewModel.fetchIngredientSearch(searchText: "Tomato")
        mockAPIManager.fetchFail(error: error)

        XCTAssertEqual(fridgeViewModel.searchedIngredients, [])
    }
    
    // MARK: - deleteIngredient function
    func test_deleteIngredient_success() {
        fridgeViewModel.fridgeIngredientList = ["Tomato", "Chicken"]

        let indicesToDelete = IndexSet(integer: 0)
        fridgeViewModel.deleteIngredient(index: indicesToDelete)
        
        XCTAssertEqual(fridgeViewModel.fridgeIngredientList, ["Chicken"])
    }
    
    // MARK: - addIngredient function
    func test_addIngredient_success() {
        fridgeViewModel.fridgeIngredientList = ["Tomato"]
        
        fridgeViewModel.addIngredient("Chicken")
        
        XCTAssertEqual(fridgeViewModel.fridgeIngredientList, ["Tomato", "Chicken"])
    }
    
    // MARK: - var selectedIngredients
    func test_selectedIngredients_noIngredient() {
        fridgeViewModel.fridgeIngredientList = []
        XCTAssertEqual(fridgeViewModel.selectedIngredients, "no.added.ingredient".localized())
    }
    
    func test_selectedIngredients_1Ingredient() {
        fridgeViewModel.fridgeIngredientList = ["Tomato"]
        XCTAssertEqual(fridgeViewModel.selectedIngredients, String(format: "selected.ingredient".localized(), String(1)))
    }
    
    func test_selectedIngredients_more1Ingredient() {
        fridgeViewModel.fridgeIngredientList = ["Tomato", "Chicken"]
        XCTAssertEqual(fridgeViewModel.selectedIngredients, String(format: "selected.ingredients".localized(), String(2)))
    }
    
}
