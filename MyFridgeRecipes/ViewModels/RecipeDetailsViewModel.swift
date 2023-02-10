//
//  RecipeDetailsViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    
   @Published var recipe: Recipes.Recipe
    
    private let repository = CDRecipesRepository()
    private let updateFavoriteRecipes: VMFavoriteRecipesProtocol
    
    init(recipe: Recipes.Recipe, updateFavoriteRecipes: VMFavoriteRecipesProtocol) {
        self.recipe = recipe
        self.updateFavoriteRecipes = updateFavoriteRecipes
        self.checkIfIsfavorite()
    }
    
    func clickedOnIsfavorite() {
        if recipe.isFavorite == true {
            recipe.isFavorite = false
            removeFavoriteRecipe(recipe: recipe)
        } else {
            recipe.isFavorite = true
            addFavoriteRecipe(newFavoriteRecipe: recipe)
        }
    }
    
    func addFavoriteRecipe(newFavoriteRecipe: Recipes.Recipe) {
        repository.addFavoriteRecipes(recipe: newFavoriteRecipe)
        updateFavoriteRecipes.updateFavoriteRecipes()
    }
    
    func removeFavoriteRecipe(recipe: Recipes.Recipe) {
        repository.removeFavoriteRecipe(recipe: recipe)
        updateFavoriteRecipes.updateFavoriteRecipes()
    }
    
    func checkIfIsfavorite() {
        repository.getFavoriteRecipes { favoriteRecipes in
            recipe.isFavorite = favoriteRecipes.contains(where: { favoriteRecipes in favoriteRecipes.label == (recipe.label ?? "") })
        }
    }
    
}
