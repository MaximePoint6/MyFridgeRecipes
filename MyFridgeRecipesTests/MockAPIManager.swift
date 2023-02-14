//
//  MockAPIManager.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 09/02/2023.
//

import Foundation
import Alamofire
@testable import MyFridgeRecipes

class MockAPIManager: APIManagerProtocol {

    var completeClosure: ((Result<Any, AFError>) -> Void)!
    
    func getRequest<T: Codable>(router: Alamofire.URLRequestConvertible, completion: @escaping (Result<T, AFError>) -> Void) {
        completeClosure = { result in
                    switch result {
                    case .success(let successResult):
                        completion(.success(successResult as! T))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func fetchSuccess<T: Codable>(result: T) {
        completeClosure(.success(result as Any))
    }
    
    func fetchFail(error: AFError) {
        completeClosure(.failure(error))
    }
}
