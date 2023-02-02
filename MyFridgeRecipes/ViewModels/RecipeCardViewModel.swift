//
//  RecipeCardView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation

class RecipeCardViewModel {
    
    let recipe: Recipes.Recipe
    
    init(recipe: Recipes.Recipe) {
        self.recipe = recipe
    }
    
    var recipeImageUrl: String {
        return self.recipe.image ?? "-"
    }
    
    var label: String {
        return self.recipe.label ?? "-"
    }
    
    var cuisineType: String {
        return self.recipe.cuisineType?.compactMap { $0 }.joined(separator: ", ") ?? ""
    }
    
}
