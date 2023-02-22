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
        // Setup MockAPIManager
        mockAPIManager = MockAPIManager()
        homeViewModel = HomeViewModel(apiManager: mockAPIManager)
        
        // Throws a false result because when initializing the viewModel fetchRandomRecipes() is launched.
        // To avoid any problem, it's therefore necessary to do a fetchSucess() before running the tests,
        // otherwise this function fetchRandomRecipes() at initialization which waits for the next the next fetchSucess().
        mockAPIManager.fetchSuccess(result: recipes)
        // Reset page state for tests
        homeViewModel.pageState = .loading
    }
    
    override func tearDown() {
        homeViewModel = nil
        mockAPIManager = nil
        super.tearDown()
    }
    
    let imageUrl = URL(string: "https://edamam-product-images.s3.amazonaws.com/web-img/404/404b794b6145f7d38324e6387afb6ae6.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFYaCXVzLWVhc3QtMSJHMEUCIBsquVV2PObWXDdKui5wDbY58Uf2lE%2FgFkxEGvcJD1WSAiEAzUGadqPJIE%2FuBlhwswZ5c9SA1%2BbVJ0aiLgygfWzTTqcq1QQIv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDLTI%2BgK2k%2BcShcIQzSqpBII20P6PCxk%2BssIk%2FVOWPRRKnhrxfqdzWSP40MKDYVEWJw9SRNCh9TLZ03ZVeB27ImPRJ%2FE9InHpjPbTsn4rRkoCuKl7%2Fgvw6MpHQqKZyFKflZytGtr7iN97zJF35FezML7igy%2FmVue8pVQhNLsE1hVfcs58F05BzCiSeba9CsEkTbr3H%2FJvPULSNXcLZJeZq8MDIceFCgF5CsfzvGQzu8f0MwWYhCF%2FsiSrorVrLRdR%2FdjkQf1HAVkcnbLvn7GaBUwk2Sw6OP3gSiBMgUB1IbizOZ6zz25lX91sPJpkhInK4SDWz5sLkCjJUTnEZdPufrI367RxGzOCbxRUdmzNwav3EQcDb9uZT4O5tRTNpA9VKCr8yIM6CFIv96uuh3Fe4juRdcjMtyYvstT921sR097H4CvATIrE3C0ycFxfCzn7RDlu%2BKyrKg%2FDM3pZeHhVmhgpLZxbEW4qn5PTHqSAVYa8kPEfVAxUd2wB5gxBw3iOsOnqdvj3Ll8vNKVD7kMzh17%2BSrcfZnVPLsgOCiRSg0JiBbiYUd0%2Fukr7kNTvduIw08snylu2nhP4hxWbmDgoun9fRlNGtaNgwn6cuoNQ7dYwV8dJNDLlnZsnCtL5g7Z%2FhsELVmXmUPtT4zuQ6M%2BGzVLCSgSuW93KakHKE8W77Rx8vAfP11zY3hOEL%2F7lqsd64vebkgTc65sy98fwXUcdsrMXhnQYNC0Hyn3XA67nkO78gG%2ByDI1LLcAwn%2Fm0ngY6qQGishWA8MQYA1tDPAcT8qBmerrn6TDoTSgpvNxLQhzN5X6EhEfTFXPNpj4b3eEborYtaVUCOzZYbFCtvUN7p11NHn2ezy9oqbr5YTARYDIM4bA3bEnJNs0YU3%2B45XR8d%2FJhP6CPr847hNjbBiN%2BieV9%2BM9F54PF%2BRMqXSm6jRgyO5shmzvJWI4jyNIU2iuQEPLZ4erw9kAkzTvdZyc%2BCVkSxKA618HR2DcV&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230122T134518Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIHHWDTDC%2F20230122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=6f707078186da4b0f401c69aae88581d4b401705cb19b2b540c1803b9b6cb8d7")
    let title = "Boulangere Potatoes"
    let calories = String(format: "kcals".localized(), 1045.801841315484/4)
    let portionNumber = String(Int(4.0))
    let preparationTime = "- " + "minute".localized()
    let cuisineType = ["french"].compactMap { $0 }.joined(separator: " - ")
    let mealType = ["lunch/dinner"].compactMap { $0 }.joined(separator: " - ")
    let shareURL = URL(string: "http://www.edamam.com/recipe/boulangere-potatoes-69188a0ed72922a8aa82f825d01d2eae/chicken+potatoes")
    
    
    // MARK: - FetchRamdomRecipes Function
    func test_FetchRandomRecipesFunction_inViewModel_success() {
        // When start fetch
        homeViewModel.fetchRandomRecipes()
        mockAPIManager.fetchSuccess(result: recipes)
        
        switch homeViewModel.pageState {
            case .loading:
                XCTFail("Request should not fail.")
            case .failed(let error):
                XCTFail("Request should not fail. Error : \(error)")
            case .loaded(let recipes):
                XCTAssertEqual(imageUrl, recipes[0].getImageUrl)
                XCTAssertEqual(title, recipes[0].getTitle)
                XCTAssertEqual(calories, recipes[0].getCalories)
                XCTAssertEqual(portionNumber, recipes[0].getPortionNumber)
                XCTAssertEqual(preparationTime, recipes[0].getPreparationTime)
                XCTAssertEqual(cuisineType, recipes[0].getCuisineType)
                XCTAssertEqual(mealType, recipes[0].getMealType)
                XCTAssertEqual(shareURL, recipes[0].getShareURL)
        }
    }
    
    func test_FetchRandomRecipesFunction_inViewModel_fail() {
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
    func test_fetchNextRecipesWithUrlFunction_inViewModel_success() {
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
    
    func test_fetchNextRecipesWithUrlFunction_inViewModel_fail() {
        // Given a failed fetch with a certain failure
        let error = AFError.sessionTaskFailed(error: MockResponseData.error)
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
    
    // MARK: - fetchRecipeSearch Function
    func test_fetchRecipeSearchFunction_inViewModel_success() {
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
    
    func test_fetchRecipeSearchFunction_inViewModel_fail_decoding() {
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
    
    func test_fetchRecipeSearchFunction_inViewModel_fail_BackEndError() {
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

