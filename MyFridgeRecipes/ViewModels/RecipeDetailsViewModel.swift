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
        do {
            try repository.addFavoriteRecipes(recipe: newFavoriteRecipe)
        } catch {
            coreDataError = true
        }
    }
    
    func removeFavoriteRecipe(recipe: Recipe) {
        do {
            try repository.removeFavoriteRecipe(recipe: recipe)
        } catch {
            coreDataError = true
        }
    }
    
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
    
    func share(this elements: [Any]) {
        shareButton(elements: elements)
    }
    
}
