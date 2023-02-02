//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    
    @Published private(set) var pageState = PageState.loading
    @Published var nextRecipesLoading = false
    
    var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
        fetchRandomRecipes()
    }
    
    private var recipes: [Recipes.Recipe] = [] {
        didSet {
            self.pageState = .loaded(recipes)
        }
    }
    
    private(set) var nextRecipesUrl: String?
    
    // MARK: - Functions
    func fetchRandomRecipes() {
        apiManager.getRequest(router: Router.fetchRandomRecipes) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? ""
                    
                    guard let hits = response.hits else {
                        self.recipes = []
                        return
                    }
                    
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
        apiManager.getRequest(router: Router.fetchNextRecipesWithUrl(nextRecipesUrl)) { (result: Result<Recipes, AFError>) in
            self.nextRecipesLoading = false
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? ""
                    
                    guard let hits = response.hits else {
                        return
                    }
                    
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
        apiManager.getRequest(router: Router.fetchRecipeSearch(searchText)) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? ""

                    guard let hits = response.hits else {
                        self.recipes = []
                        return
                    }
                    
                    self.recipes = hits
                        .filter { $0.recipe != nil }
                        .map { $0.recipe! }
                    
                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
}
