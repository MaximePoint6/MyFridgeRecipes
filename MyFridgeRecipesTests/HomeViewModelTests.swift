//
//  HomeViewModelTests.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 09/02/2023.
//

import XCTest
import Alamofire
@testable import MyFridgeRecipes

final class HomeViewModelTests: XCTestCase {
    
    var homeViewModel: HomeViewModel!
    var mockAPIManager: MockAPIManager!
    var recipes: Recipes!
    
    override func setUp() {
        super.setUp()
        // Given a success fetch with a certain data
        recipes = MockData.previewRecipes
        // setup MockAPIManager
        mockAPIManager = MockAPIManager()
        homeViewModel = HomeViewModel(apiManager: mockAPIManager)
        mockAPIManager.fetchSuccess(result: recipes)
    }
    
    override func tearDown() {
        homeViewModel = nil
        mockAPIManager = nil
        super.tearDown()
    }
    
    
    // MARK: - FetchRamdomRecipes Function
    func test_FetchRandomRecipesFunction_InViewModel() {
        // When start fetch
        homeViewModel.fetchRandomRecipes()
        mockAPIManager.fetchSuccess(result: recipes)
        
        let label = "Boulangere Potatoes"
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(label, recipes[0].label)
        }
    }
    
    func test_FetchRandomRecipesFunction_InViewModel_fail() {
        // Given a failed fetch with a certain failure
        let error = AFError.responseValidationFailed(reason: .dataFileNil)
        // When start fetch
        homeViewModel.fetchRandomRecipes()
        mockAPIManager.fetchFail(error: error)
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(ErrorManager.ErrorType.otherProblem, error)
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    
    // MARK: - fetchNextRecipesWithUrl Function
    func test_fetchNextRecipesWithUrlFunction_InViewModel() {
        // Add a nextRecipesUrl
        homeViewModel.nextRecipesUrl = recipes._links!.next!.href!
        // When start fetch
        homeViewModel.fetchNextRecipesWithUrl()
        mockAPIManager.fetchSuccess(result: recipes)
        
        let label = "Boulangere Potatoes"
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(label, recipes[0].label)
        }
    }
    
    func test_fetchNextRecipesWithUrlFunction_InViewModel_fail() {
        // Given a failed fetch with a certain failure
        let error = AFError.sessionTaskFailed(error: MockResponseData.error)
        // Add a nextRecipesUrl
        homeViewModel.nextRecipesUrl = MockData.previewRecipes._links!.next!.href!
        // When start fetch
        homeViewModel.fetchNextRecipesWithUrl()
        mockAPIManager.fetchFail(error: error)
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(ErrorManager.ErrorType.noInternet, error)
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    func test_fetchNextRecipesWithUrlFunction_InViewModel_Return() {
        // Given a failed fetch with a certain failure
        let error = AFError.sessionTaskFailed(error: MockResponseData.error)
        // Remove the nextRecipesUrl
        homeViewModel.nextRecipesUrl = nil
        homeViewModel.pageState = .loading
        // When start fetch
        homeViewModel.fetchNextRecipesWithUrl()
        
        switch homeViewModel.pageState {
            case .loading:
                XCTAssert(true)
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    // MARK: - fetchRecipeSearch Function
    func test_fetchRecipeSearchFunction_InViewModel() {
        // When start fetch
        homeViewModel.fetchRecipeSearch(searchText: "Tomato")
        mockAPIManager.fetchSuccess(result: recipes)
        
        let label = "Boulangere Potatoes"
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(label, recipes[0].label)
        }
    }
    
    func test_fetchRecipeSearchFunction_InViewModel_fail() {
        // Given a failed fetch with a certain failure
        let error = AFError.responseSerializationFailed(reason: .inputFileNil)
        // When start fetch
        homeViewModel.fetchRecipeSearch(searchText: "Tomato")
        mockAPIManager.fetchFail(error: error)
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(ErrorManager.ErrorType.decoding, error)
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    func test_fetchRecipeSearchFunction_InViewModel_fail_BackEndError() {
        // Given a failed fetch with a certain failure
        let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500))
        // When start fetch
        homeViewModel.fetchRecipeSearch(searchText: "Tomato")
        mockAPIManager.fetchFail(error: error)
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(ErrorManager.ErrorType.backend(500), error)
            case .loaded:
                XCTFail("Request should not fail.")
        }
    }
    
    
    
    
    
}

