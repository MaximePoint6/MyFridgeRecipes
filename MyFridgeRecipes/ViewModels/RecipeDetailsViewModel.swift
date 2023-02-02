//
//  RecipeDetailsViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation


class RecipeDetailsViewModel {
    
    var recipe: Recipes.Recipe
    
    init(recipe: Recipes.Recipe) {
        self.recipe = recipe
    }
    
    var titleRecipe: String {
        return self.recipe.label ?? "-"
    }
}
