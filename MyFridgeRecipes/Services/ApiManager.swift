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
    
    // URL Session customisé
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        // récupere le cache quand il y a pas de reseau, et quand on recupere des datas mise en cache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        
        let networkLogger = NetworkLogger()
        let interceptor = MyRequestInterceptor()
        
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
    }()
    
    
    // MARK: - Functions
    func fetchFoodSearch(query: String, completion: @escaping ([String]) -> Void) {
        sessionManager.request(Router.fetchFoodSearch(query))
            .responseDecodable(of: [String].self) { response in
                guard let foods = response.value else {
                    return completion([])
                }
                completion(foods)
            }
    }
    
    func fetchRecipeSearch(query: String, completion: @escaping (Recipes?) -> Void) {
        sessionManager.request(Router.fetchRecipeSearch(query))
            .responseDecodable(of: Recipes.self, decoder: SnakeCaseJSONDecoder()) { response in
                guard let recipes = response.value else {
                    return completion(nil)
                }
                completion(recipes)
            }
    }
}
