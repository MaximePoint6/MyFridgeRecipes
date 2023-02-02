//
//  FridgeViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import Foundation
import Alamofire

class FridgeViewModel: ObservableObject {
    
    @Published private(set) var pageState = PageState.loading
    @Published private(set) var nextRecipesLoading = false

    var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    private var recipes: [Recipes.Recipe] = [] {
        didSet {
            self.pageState = .loaded(recipes)
        }
    }
    
    private(set) var nextRecipesUrl: String?
    
    // MARK: - Functions

    func fetchRecipeSearch(searchText: String) {
        apiManager.getRequest(router: Router.fetchRecipeSearch(searchText)) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? nil

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
    
    
}
