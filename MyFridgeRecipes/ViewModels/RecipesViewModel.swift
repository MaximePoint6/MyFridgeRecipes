//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation

class RecipesViewModel: ObservableObject {
    
    @Published var recipes: [Recipes.Hit] = []
    
//    func fetchList() {
//      guard let data = data else { return }
//      switch data {
//      case is Film:
//        fetch(data.listItems, of: Starship.self)
//      default:
//        print("Unknown type: ", String(describing: type(of: data)))
//      }
//    }
    
    func fetchFoodSearch() {
        APIManager.shared.fetchFoodSearch(query: "tom") { foods in
            print(foods)
        }
    }
    
    func fetchRecipeSearch() {
        APIManager.shared.fetchRecipeSearch(query: "potatoes chicken") { recipes in
            guard let recipes = recipes else {
                return
            }
            self.recipes = recipes.hits!
        }
    }
    
}
