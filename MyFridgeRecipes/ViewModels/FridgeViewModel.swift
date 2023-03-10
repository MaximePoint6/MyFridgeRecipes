//
//  FridgeViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import Foundation
import Alamofire

class FridgeViewModel: ObservableObject {
    
    @Published var pageState = PageState.loading
    @Published private(set) var nextRecipesLoading = false
    @Published var fridgeIngredientList = [String]()
    @Published var searchedIngredients: [String] = []
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    // MARK: - Privates properties
    
    private var nextRecipesUrl: String?
    
    /// Array of stored recipes to update the pageState.
    private var recipes: [Recipe] = [] {
        didSet {
            self.pageState = .loaded(recipes)
        }
    }
    
    /// Returns a fridge ingredient list, comma separated, of type String.
    private var foodsString: String {
        return fridgeIngredientList.compactMap { $0 }.joined(separator: ", ")
    }
    
    // MARK: - UI
    
    /// Returns a sentence including the number of selected fridge ingredients.
    var selectedIngredients: String {
        if fridgeIngredientList.count == 0 {
            return "no.added.ingredient".localized()
        } else if fridgeIngredientList.count == 1 {
            return String(format: "selected.ingredient".localized(), String(fridgeIngredientList.count))
        } else {
            return String(format: "selected.ingredients".localized(), String(fridgeIngredientList.count))
        }
    }
    
    // MARK: - Functions
    
    /// To get the recipes based on the fridge Ingredien tList (var foodsString).
    func fetchRecipeSearch() {
        self.pageState = PageState.loading
        apiManager.getRequest(router: APIRouter.fetchRecipeSearch(self.foodsString)) { (result: Result<Recipes, AFError>) in
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
        guard let nextRecipesUrl = self.nextRecipesUrl else {
            return
        }
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
    
    /// To get the ingredients based on a search.
    /// - Parameter searchText: ingredient to search.
    func fetchIngredientSearch(searchText: String) {
        apiManager.getRequest(router: APIRouter.fetchIngredientSearch(searchText)) { (result: Result<[String], AFError>) in
            switch result {
                case .success(let response):
                    self.searchedIngredients = response
                case .failure:
                    self.searchedIngredients = []
            }
        }
    }
    
    /// Delete the ingredient from the fridge ingredient list.
    /// - Parameter index: ingredient index
    func deleteIngredient(index: IndexSet) {
        fridgeIngredientList.remove(atOffsets: index)
    }
    
    /// Add the ingredient from the fridge ingredient list.
    /// - Parameter ingredient: ingredient name
    func addIngredient(_ ingredient: String) {
        fridgeIngredientList.append(ingredient)
    }
    
    // MARK: - Privates functions
    
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
