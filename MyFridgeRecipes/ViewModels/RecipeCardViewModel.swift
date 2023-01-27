//
//  RecipeCardView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation
import SwiftUI
import Alamofire

class RecipeCardViewModel: ObservableObject {
    
    let recipe: Recipes.Recipe
    
    init(recipe: Recipes.Recipe, apiManager: APIManager = APIManager.shared) {
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
