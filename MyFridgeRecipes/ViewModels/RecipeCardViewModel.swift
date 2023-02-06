//
//  RecipeCardView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation

class RecipeCardViewModel: ObservableObject {
    
    @Published var recipe: Recipes.Recipe
    
    init(recipe: Recipes.Recipe) {
        self.recipe = recipe
    }

}
