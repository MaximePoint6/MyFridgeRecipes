//
//  APIManagerTests.swift
//  My fridge recipesTests
//
//  Created by Maxime Point on 20/01/2023.
//

import XCTest
import Alamofire
import Mocker
@testable import MyFridgeRecipes

final class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let session = Session(configuration: configuration)
        apiManager = APIManager(sessionManager: session)
    }
    
    override func tearDown() {
        apiManager = nil
        Mocker.removeAll()
        super.tearDown()
    }
    
    
    func testAPIManager_success() {
        // Inform the router of the request
        let routerURLRequest = try! APIRouter.fetchRandomRecipes.asURLRequest()
        
        // Create a MockResponseData with the router
        let mock = MockResponseData.mockResponseOK(router: routerURLRequest)
        mock.register() // Save this mock using the Mocker library
        
        let expectation = self.expectation(description: "Request should succeed")

        apiManager.getRequest(router: APIRouter.fetchRandomRecipes) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    let label = "Boulangere Potatoes"
                    XCTAssertEqual(label, response.hits![0].recipe!.label)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Request should not fail. Error : \(error)")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testAPIManager_fail() {
        // Inform the router of the request
        let router = try! APIRouter.fetchRandomRecipes.asURLRequest()
        
        // Create a MockResponseData with the router
        let mock = MockResponseData.mockResponseKO(router: router)
        mock.register() // Save this mock using the Mocker library
        
        let expectation = self.expectation(description: "Request should succeed")

        apiManager.getRequest(router: APIRouter.fetchRandomRecipes) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success:
                    XCTFail("Request should not fail.")
                case .failure(let error):
                    XCTAssertNotNil(error)
                    XCTAssertEqual(AFError.sessionTaskFailed(error: MockResponseData.error), error)
                    expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 50.0)
    }
    
}
