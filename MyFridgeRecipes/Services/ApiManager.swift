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
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
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
            .responseDecodable(of: Recipes.self) { response in
                guard let recipes = response.value else {
                    return completion(nil)
                }
                completion(recipes)
            }
    }
    
    //  func fetchPopularSwiftRepositories(completion: @escaping ([Repository]) -> Void) {
    //    searchRepositories(query: "language:Swift", completion: completion)
    //  }
    //
    //  func fetchCommits(for repository: String, completion: @escaping ([Commit]) -> Void) {
    //    sessionManager.request(Router.fetchCommits(repository))
    //      .responseDecodable(of: [Commit].self) { response in
    //        guard let commits = response.value else {
    //          return
    //        }
    //        completion(commits)
    //      }
    //  }
    //
    //  func searchRepositories(query: String, completion: @escaping ([Repository]) -> Void) {
    //    sessionManager.request(Router.searchRepositories(query))
    //      .responseDecodable(of: Repositories.self) { response in
    //        guard let repositories = response.value else {
    //          return completion([])
    //        }
    //        completion(repositories.items)
    //      }
    //  }
    //
    //  func fetchUserRepositories(completion: @escaping ([Repository]) -> Void) {
    //    sessionManager.request(Router.fetchUserRepositories)
    //      .responseDecodable(of: [Repository].self) { response in
    //        guard let repositories = response.value else {
    //          return completion([])
    //        }
    //        completion(repositories)
    //      }
    //  }
}
