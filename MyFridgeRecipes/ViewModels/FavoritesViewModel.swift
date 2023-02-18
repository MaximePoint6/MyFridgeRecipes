//
//  FavoritesViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 06/02/2023.
//

import Foundation


class FavoritesViewModel: ObservableObject {
    
    @Published var pageState = PageState.loading
    @Published var coreDataError = false
    
    private let repository = CDRecipesRepository()
    
    init() {
        updateFavoriteRecipes()
    }
    
    private var favoriteRecipes: [Recipe] = [] {
        didSet {
            self.pageState = .loaded(favoriteRecipes)
        }
    }
    
    func updateFavoriteRecipes() {
        repository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    self.favoriteRecipes = response
                case .failure:
                    coreDataError = true
            }
        }
    }
    
    func getFilteredRecipes(searchText: String) {
        repository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    self.favoriteRecipes = response.filter({ recipe in
                        if let label = recipe.label {
                            return label.lowercased().contains(searchText.lowercased())
                        } else {
                            return false
                        }
                    })
                case .failure:
                    coreDataError = true
            }
        }
    }
    
}
