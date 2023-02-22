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
    
    private let repository: CDRecipesRepository
    
    init(repository: CDRecipesRepository = CDRecipesRepository()) {
        self.repository = repository
        updateFavoriteRecipes()
    }
    
    // MARK: - Other properties
    
    /// Array of stored recipes to update the pageState.
    private var favoriteRecipes: [Recipe] = [] {
        didSet {
            self.pageState = .loaded(favoriteRecipes)
        }
    }
    
    // MARK: - Functions
    
    /// To get all the favorite recipes (CoreData).
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
    
    /// To get the favorite recipes filtered according to a search (CoreData).
    /// - Parameter searchText: recipe to search.
    func getFilteredRecipes(searchText: String) {
        repository.getFavoriteRecipes { (result: Result<[Recipe], Error>) in
            switch result {
                case .success(let response):
                    self.favoriteRecipes = response.filter({ recipe in
                        guard let label = recipe.label else { return false }
                        return label.lowercased().contains(searchText.lowercased())
                    })
                case .failure:
                    coreDataError = true
            }
        }
    }
    
}
