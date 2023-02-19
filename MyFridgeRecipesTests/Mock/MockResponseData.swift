//
//  MockResponseData.swift
//  APIManagerTests
//
//  Created by Maxime Point on 03/02/2023.
//

import Foundation
import Mocker
import Alamofire
@testable import MyFridgeRecipes

class MockResponseData {
    
    // MARK: Reponse Mock
    static func mockResponseOK(router: URLRequest) -> Mock {
        return Mock(url: router.url!,
                    dataType: .json,
                    statusCode: 200,
                    data: [ .get: try! Data(contentsOf: recipesCorrectData) ]  // Data containing the JSON response
        )
    }
    
    static func mockResponseKO(router: URLRequest) -> Mock {
        return Mock(url: router.url!,
                    dataType: .json,
                    statusCode: 500,
                    data: [ .get: Data() ],
                    requestError: MockResponseData.error
        )
    }
    
    // MARK: Mock error
    class TestError: Error { }
    static let error = TestError()
    
    // MARK: Mock correct datas
    static let recipesCorrectData: URL = Bundle.main.url(forResource: "Recipes", withExtension: "json")!
}
