//
//  Router.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

enum Router {
    case fetchUserRepositories
    case searchRepositories(String)
    case fetchCommits(String)
    case fetchFoodSearch(String)
    case fetchRecipeSearch(String)
    
    var baseURL: String {
        switch self {
            case .fetchUserRepositories, .searchRepositories, .fetchCommits:
                return "https://api.github.com"
            case .fetchFoodSearch, .fetchRecipeSearch:
                return "https://api.edamam.com"
        }
    }
    
    var path: String {
        switch self {
            case .fetchUserRepositories:
                return "/user/repos"
            case .searchRepositories:
                return "/search/repositories"
            case .fetchCommits(let repository):
                return "/repos/\(repository)/commits"
            case .fetchFoodSearch:
                return "/auto-complete"
            case .fetchRecipeSearch:
                return "/api/recipes/v2"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .fetchUserRepositories:
                return .get
            case .searchRepositories:
                return .get
            case .fetchCommits:
                return .get
            case .fetchFoodSearch, .fetchRecipeSearch:
                return .get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
            case .fetchUserRepositories:
                return ["per_page": "100"]
            case .searchRepositories(let query):
                return ["sort": "stars", "order": "desc", "page": "1", "q": query]
            case .fetchCommits:
                return nil
            case .fetchFoodSearch(let query):
                return ["app_id": ApiKey.adamamFoodDatabaseID, "app_key": ApiKey.adamamFoodDatabase, "q": query, "limit": "10"]
            case .fetchRecipeSearch(let query):
                return ["app_id": ApiKey.adamamRecipeSearchID, "app_key": ApiKey.adamamRecipeSearch, "type": "any", "q": query, "limit": "10"]
        }
    }
}

// MARK: - URLRequestConvertible
extension Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
                .encode(parameters, into: request)
        } else if method == .post {
            request = try JSONParameterEncoder().encode(parameters, into: request)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        return request
    }
}

