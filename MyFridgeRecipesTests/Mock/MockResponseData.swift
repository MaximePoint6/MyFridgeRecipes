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
    static let recipesCorrectData: URL = Bundle(for: MockResponseData.self).url(forResource: "Recipes", withExtension: "json")!
    
    // static let recipesIncorrectData = "erreur".data(using: .utf8)!
    //    static let botAvatarImageResponseHead: Data = try! Data(contentsOf: Bundle(for: MockedData.self).url(forResource: "Resources/Responses/bot-avatar-image-head", withExtension: "data")!)
    //    static let botAvatarImageFileUrl: URL = Bundle(for: MockedData.self).url(forResource: "wetransfer_bot_avater", withExtension: "png")!
    //    static var recipesCorrectData: Data? {
    //        let bundle = Bundle(for: MockResponseData.self)
    //        let url = bundle.url(forResource: "Recipes", withExtension: "json")!
    //        let data = try! Data(contentsOf: url)
    //        return data
    //    }
}
