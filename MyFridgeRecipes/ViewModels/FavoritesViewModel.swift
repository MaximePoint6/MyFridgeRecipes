//
//  FavoritesViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 06/02/2023.
//

import Foundation


class FavoritesViewModel: ObservableObject {
    
    @Published var pageState = PageState.loading
    
    private let repository = CDRecipesRepository()
    
    init() {
        updateFavoriteRecipes()
    }
    
    private var favoriteRecipes: [Recipes.Recipe] = [] {
        didSet {
            self.pageState = .loaded(favoriteRecipes)
        }
    }
    
    func updateFavoriteRecipes() {
        repository.getFavoriteRecipes { recipes in
            self.favoriteRecipes = recipes
        }
    }
    
    func getFilteredRecipes(searchText: String) {
        repository.getFavoriteRecipes { recipes in
            self.favoriteRecipes = recipes.filter({ recipe in
                if let label = recipe.label {
                    return label.lowercased().contains(searchText.lowercased())
                } else {
                    return false
                }
            })
        }
    }
    
}
