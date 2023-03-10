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
    @Published private(set) var nextRecipesLoading = false
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
        fetchRandomRecipes()
    }
    
    // MARK: - Other properties
    
    private var nextRecipesUrl: String?
    
    /// Array of stored recipes to update the pageState.
    private var recipes: [Recipe] = [] {
        didSet {
            self.pageState = .loaded(recipes)
        }
    }
    
    // MARK: - Functions
    
    /// To get random recipes.
    func fetchRandomRecipes() {
        apiManager.getRequest(router: APIRouter.fetchRandomRecipes) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.updatesOrAddValidRecipes(actionType: .updateRecipes, recipes: response)
                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
    
    /// To get the next recipes.
    func fetchNextRecipesWithUrl() {
        guard let nextRecipesUrl = self.nextRecipesUrl else { return }
        guard !nextRecipesLoading else { return }
        
        self.nextRecipesLoading = true
        apiManager.getRequest(router: APIRouter.fetchNextRecipesWithUrl(nextRecipesUrl)) { (result: Result<Recipes, AFError>) in
            self.nextRecipesLoading = false
            switch result {
                case .success(let response):
                    self.updatesOrAddValidRecipes(actionType: .addRecipes, recipes: response)
                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
    
    /// To get the recipes based on a search.
    /// - Parameter searchText: recipe to search.
    func fetchRecipeSearch(searchText: String) {
        self.pageState = PageState.loading
        apiManager.getRequest(router: APIRouter.fetchRecipeSearch(searchText)) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.updatesOrAddValidRecipes(actionType: .updateRecipes, recipes: response)
                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
    
    // MARK: - Privates Functions
    
    /// Checks if the recipes received as parameters are valid (not null),
    /// formats the recipes and then adds the recipes in the recipes variable or replaces them according to the actionType parameter.
    /// - Parameters:
    ///   - actionType: add new recipes or update (replace) existing recipes.
    ///   - recipes: recipes to add or replace.
    private func updatesOrAddValidRecipes(actionType: ActionType, recipes: Recipes) {
        self.nextRecipesUrl = recipes._links?.next?.href ?? nil
        guard let hits = recipes.hits else { return self.recipes = [] }
        
        let newRecipes = hits
            .filter { $0.recipe != nil }
            .map { $0.recipe! }
        
        switch actionType {
            case .addRecipes:
                self.recipes.append(contentsOf: newRecipes)
            case .updateRecipes:
                self.recipes = newRecipes
        }
    }
    
}
