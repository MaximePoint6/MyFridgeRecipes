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
    
    private var recipes: [Recipes.Recipe] = [] {
        didSet {
            self.pageState = .loaded(recipes)
        }
    }
    
    private var nextRecipesUrl: String?
    
    private var foodsString: String {
        return fridgeIngredientList.compactMap { $0 }.joined(separator: ", ")
    }
    
    // MARK: - Functions
    
    func fetchRecipeSearch() {
        self.pageState = PageState.loading
        apiManager.getRequest(router: APIRouter.fetchRecipeSearch(self.foodsString)) { (result: Result<Recipes, AFError>) in
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
    
    // MARK: - UI
    
    var selectedIngredients: String {
        if fridgeIngredientList.count == 0 {
            return "no.ingredient.selected".localized()
        } else if fridgeIngredientList.count == 0 {
            return String(format: "selected.ingredient".localized(), String(fridgeIngredientList.count))
        } else {
            return String(format: "selected.ingredients".localized(), String(fridgeIngredientList.count))
        }
    }
    
    
}
