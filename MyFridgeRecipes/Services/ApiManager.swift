//
//  ApiManager.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    // Custom Session
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        // Code caching the data, and if there is no network, we recover the cache.
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        
        // To put logs in console
        let networkLogger = NetworkLogger()
        // Retry a request that had an error (settings: max retry, delay, etc.)
        let interceptor = MyRequestInterceptor()
        
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
    }()
    
    
    // MARK: - Function performing network requests
    
    func fetchFoodSearch(query: String, completion: @escaping (Result<[String], AFError>) -> Void) {
        sessionManager.request(Router.fetchFoodSearch(query))
            .responseDecodable(of: [String].self) { response in
                switch response.result {
                    case .success(let foods):
                        completion(.success(foods))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func fetchRecipeSearch(query: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        sessionManager.request(Router.fetchRecipeSearch(query))
            .responseDecodable(of: Recipes.self, decoder: SnakeCaseJSONDecoder()) { response in
                switch response.result {
                    case .success(let recipes):
                        completion(.success(recipes))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
}
