//
//  MockAPIManager.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 09/02/2023.
//

import Foundation
import Alamofire
@testable import MyFridgeRecipes


/// Use to test ViewModels (because the goal isn't to test the APIManager for these tests)
class MockAPIManager: APIManagerProtocol {

    /// Closure waiting to be completed by the fetchSuccess or fetchFail functions, to restart getRequest completion.
    var completeClosure: ((Result<Any, AFError>) -> Void)!
    
    /// Simulates the function launching the requests in the API Manager.
    /// - Parameters:
    ///   - router: Provide the desired router to launch the request (allows to add to the request, the url, the parameters, the method ...).
    ///   - completion: Returns the desired mock completion.
    func getRequest<T: Decodable>(router: Alamofire.URLRequestConvertible, completion: @escaping (Result<T, AFError>) -> Void) {
        completeClosure = { result in
                    switch result {
                    case .success(let successResult):
                        completion(.success(successResult as! T))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    /// This function is used to add and therefore simulate a success of the getRequest function.
    /// - Parameter result: the object that will complete the completion of the getRequest function.
    func fetchSuccess<T: Decodable>(result: T) {
        completeClosure(.success(result as Any))
    }
    
    /// This function is used to add a error and therefore simulate a failure of the getRequest function.
    /// - Parameter result: the AFError that will complete the completion of the getRequest function.
    func fetchFail(error: AFError) {
        completeClosure(.failure(error))
    }
}
