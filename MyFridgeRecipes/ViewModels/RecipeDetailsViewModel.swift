//
//  RecipeDetailsViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    
    @Published var recipe: Recipe
    var favoritesViewModel: FavoritesViewModel?
    
    private let repository = CDRecipesRepository()
    
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.checkIfIsfavorite()
    }
    
    func setupFavoritesViewModel(favoritesViewModel: FavoritesViewModel) {
        self.favoritesViewModel = favoritesViewModel
    }
    
    func clickedOnIsfavorite() {
        if recipe.isFavorite == true {
            recipe.isFavorite = false
            removeFavoriteRecipe(recipe: recipe)
        } else {
            recipe.isFavorite = true
            addFavoriteRecipe(newFavoriteRecipe: recipe)
        }
        self.favoritesViewModel?.updateFavoriteRecipes()
    }
    
    func addFavoriteRecipe(newFavoriteRecipe: Recipe) {
        repository.addFavoriteRecipes(recipe: newFavoriteRecipe)
    }
    
    func removeFavoriteRecipe(recipe: Recipe) {
        repository.removeFavoriteRecipe(recipe: recipe)
    }
    
    func checkIfIsfavorite() {
        repository.getFavoriteRecipes { favoriteRecipes in
            recipe.isFavorite = favoriteRecipes.contains(where: { favoriteRecipes in favoriteRecipes.label == (recipe.label ?? "") })
        }
    }
    
    func share(this elements: [Any]) {
        shareButton(elements: elements)
    }
    
}
