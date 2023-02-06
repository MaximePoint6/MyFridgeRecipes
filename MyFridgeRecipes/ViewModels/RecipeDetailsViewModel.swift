//
//  RecipeDetailsViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    
    let recipe: Recipes.Recipe
    @Published var isFavorite: Bool = false
    
    private let repository = CDRecipesRepository()
    
    init(recipe: Recipes.Recipe) {
        self.recipe = recipe
        self.checkIfIsfavorite()
    }
    
    func clickedOnIsfavorite() {
        if self.isFavorite {
            self.isFavorite = false
            removeFavoriteRecipe(recipe: recipe)
        } else {
            self.isFavorite = true
            addFavoriteRecipe(newFavoriteRecipe: recipe)
        }
    }
    
    func addFavoriteRecipe(newFavoriteRecipe: Recipes.Recipe) {
        repository.addFavoriteRecipes(recipe: newFavoriteRecipe)
    }
    
    func removeFavoriteRecipe(recipe: Recipes.Recipe) {
        repository.removeFavoriteRecipe(recipe: recipe)
    }
    
    func checkIfIsfavorite() {
        repository.getFavoriteRecipes { favoriteRecipes in
            self.isFavorite = favoriteRecipes.contains(where: { favoriteRecipes in favoriteRecipes.label == (recipe.label ?? "") })
        }
    }
    
}
