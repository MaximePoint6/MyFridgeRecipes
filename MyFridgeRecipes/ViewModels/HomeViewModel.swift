//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    
    @Published var pageState = PageState.loading
    @Published var nextRecipesLoading = false
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
        fetchRandomRecipes()
    }
    
    // MARK: - Privates var
    
    private var recipes: [Recipes.Recipe] = [] {
        didSet {
            self.pageState = .loaded(recipes)
        }
    }
    
    var nextRecipesUrl: String?
    
    // MARK: - Functions
    func fetchRandomRecipes() {
        apiManager.getRequest(router: APIRouter.fetchRandomRecipes) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? nil
                    
                    guard let hits = response.hits else { return self.recipes = [] }
                    
                    self.recipes = hits
                        .filter { $0.recipe != nil }
                        .map { $0.recipe! }

                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
    
    func fetchNextRecipesWithUrl() {
        guard let nextRecipesUrl = self.nextRecipesUrl else {
            return
        }
        self.nextRecipesLoading = true
        apiManager.getRequest(router: APIRouter.fetchNextRecipesWithUrl(nextRecipesUrl)) { (result: Result<Recipes, AFError>) in
            self.nextRecipesLoading = false
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? nil
                    
                    guard let hits = response.hits else { return }
                    
                    let newRecipes = hits
                        .filter { $0.recipe != nil }
                        .map { $0.recipe! }
                    
                    self.recipes.append(contentsOf: newRecipes)

                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
    
    func fetchRecipeSearch(searchText: String) {
        self.pageState = PageState.loading
        apiManager.getRequest(router: APIRouter.fetchRecipeSearch(searchText)) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? nil

                    guard let hits = response.hits else { return self.recipes = [] }
                    
                    self.recipes = hits
                        .filter { $0.recipe != nil }
                        .map { $0.recipe! }
                    
                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
}
