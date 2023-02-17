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
    @Published var ingredients: [String] = []
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    // MARK: - Privates var
    
    private var nextRecipesUrl: String?
    
    private var recipes: [Recipe] = [] {
        didSet {
            self.pageState = .loaded(recipes)
        }
    }
    
    private enum ActionType {
        case add
        case update
    }
    
    private var foodsString: String {
        return fridgeIngredientList.compactMap { $0 }.joined(separator: ", ")
    }
    
    // MARK: - Functions
    
    func fetchRecipeSearch() {
        self.pageState = PageState.loading
        apiManager.getRequest(router: APIRouter.fetchRecipeSearch(self.foodsString)) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.updatesOrAddValidRecipes(actionType: .update, recipes: response)
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
                    self.updatesOrAddValidRecipes(actionType: .add, recipes: response)
                case .failure(let error):
                    self.pageState = ErrorManager.getErrorPageState(error: error)
            }
        }
    }
    
    func fetchFoodSearch(searchText: String) {
        apiManager.getRequest(router: APIRouter.fetchFoodSearch(searchText)) { (result: Result<[String], AFError>) in
            switch result {
                case .success(let response):
                    self.ingredients = response
                case .failure:
                    self.ingredients = []
            }
        }
    }
    
    func deleteItems(index: IndexSet) {
        fridgeIngredientList.remove(atOffsets: index)
    }
    
    func addIngredient(_ ingredient: String) {
        fridgeIngredientList.append(ingredient)
    }
    
    private func updatesOrAddValidRecipes(actionType: ActionType, recipes: Recipes) {
        self.nextRecipesUrl = recipes._links?.next?.href ?? nil
        guard let hits = recipes.hits else { return self.recipes = [] }
        
        let newRecipes = hits
            .filter { $0.recipe != nil }
            .map { $0.recipe! }
        
        switch actionType {
            case .add:
                self.recipes.append(contentsOf: newRecipes)
            case .update:
                self.recipes = newRecipes
        }
    }
    
    // MARK: - UI
    
    var selectedIngredients: String {
        if fridgeIngredientList.count == 0 {
            return "no.added.ingredient".localized()
        } else if fridgeIngredientList.count == 1 {
            return String(format: "selected.ingredient".localized(), String(fridgeIngredientList.count))
        } else {
            return String(format: "selected.ingredients".localized(), String(fridgeIngredientList.count))
        }
    }
    
    
}
