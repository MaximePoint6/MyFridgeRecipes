//
//  APIRouter.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

enum APIRouter {
    case fetchFoodSearch(String)
    case fetchRecipeSearch(String)
    case fetchRandomRecipes
    case fetchNextRecipesWithUrl(String)
    case fetchImage(String)
    
    var baseURL: String {
        switch self {
            case .fetchFoodSearch, .fetchRecipeSearch, .fetchRandomRecipes:
                return "https://api.edamam.com"
            case .fetchNextRecipesWithUrl(let url), .fetchImage(let url):
                return url
        }
    }
    
    var path: String {
        switch self {
            case .fetchFoodSearch:
                return "/auto-complete"
            case .fetchRecipeSearch, .fetchRandomRecipes:
                return "/api/recipes/v2"
            case .fetchNextRecipesWithUrl, .fetchImage:
                return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .fetchFoodSearch, .fetchRecipeSearch, .fetchRandomRecipes, .fetchNextRecipesWithUrl, .fetchImage:
                return .get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
            case .fetchFoodSearch(let query):
                return ["app_id": APIKeys.edamamFoodDatabaseID, "app_key": APIKeys.edamamFoodDatabase, "q": query, "limit": "10"]
            case .fetchRecipeSearch(let query):
                return ["app_id": APIKeys.edamamRecipeSearchID, "app_key": APIKeys.edamamRecipeSearch, "type": "any", "q": query]
            case .fetchRandomRecipes:
                return ["app_id": APIKeys.edamamRecipeSearchID, "app_key": APIKeys.edamamRecipeSearch, "type": "any", "random": "true", "ingr": "1-10"]
            case .fetchNextRecipesWithUrl, .fetchImage:
                return nil
        }
    }
}

// MARK: - URLRequestConvertible
extension APIRouter: URLRequestConvertible {
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

