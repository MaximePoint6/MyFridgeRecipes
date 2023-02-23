//
//  RecipeDetailsViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    
    @Published var recipe: Recipe
    @Published var coreDataError = false
    
    private let repository: CDRecipesRepository
    
    init(recipe: Recipe, repository: CDRecipesRepository = CDRecipesRepository()) {
        self.repository = repository
        self.recipe = recipe
        self.checkIfIsfavorite()
    }
    
    // MARK: - Functions
    
    /// Add or remove a favorite recipe.
    func clickedOnIsfavorite() {
        if recipe.isFavorite == true {
            recipe.isFavorite = false
            removeFavoriteRecipe(recipe: recipe)
        } else {
            recipe.isFavorite = true
            addFavoriteRecipe(newFavoriteRecipe: recipe)
        }
    }
    
    /// Check if this recipe is in the favorites.
    func checkIfIsfavorite() {
        guard let label = recipe.label else { return }
        repository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    recipe.isFavorite = response.contains(where: { response in response.label == (label) })
                case .failure:
                    coreDataError = true
            }
        }
    }
    
    /// Starts the share view.
    /// - Parameter elements: elements to share.
    func share(this elements: [Any]) {
        showShareView(elements: elements)
    }
    
    // MARK: - Private Functions
    
    /// To add a favorite recipe (CoreData). Function that can return an error.
    /// - Parameter newFavoriteRecipe: the recipe to add.
    private func addFavoriteRecipe(newFavoriteRecipe: Recipe) {
        do {
            try repository.addFavoriteRecipes(recipe: newFavoriteRecipe)
        } catch {
            coreDataError = true
        }
    }
    
    /// To remove a favorite recipe. Function that can return an error.
    /// - Parameter recipe: the recipe to delete.
    private func removeFavoriteRecipe(recipe: Recipe) {
        do {
            try repository.removeFavoriteRecipe(recipe: recipe)
        } catch {
            coreDataError = true
        }
    }
    
}
