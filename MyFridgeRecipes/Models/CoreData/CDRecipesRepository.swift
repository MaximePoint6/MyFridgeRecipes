//
//  CDRecipesRepository.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 06/02/2023.
//

import Foundation
import CoreData

final class CDRecipesRepository {
    
    // MARK: - Properties
    private let cdManager: CDManager
    
    // MARK: - Init
    init(coreDataStack: CDManager = CDManager.shared) {
        self.cdManager = coreDataStack
    }
    
    // MARK: - Repository
    func getFavoriteRecipes(completion: (Result<[Recipe], Error>) -> Void) {
        let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        do {
            let favoriteRecipes = try cdManager.viewContext.fetch(request)
            let recipes = favoriteRecipes.compactMap({ (rawRecipe: CDRecipe) -> Recipe? in
                Recipe(fromCoreDataObject: rawRecipe)
            })
            completion(.success(recipes))
        } catch {
            print("Error while retrieving CoreData data: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func addFavoriteRecipes(recipe: Recipe) throws {
        let newFavoriteRecipe = CDRecipe(context: cdManager.viewContext)
        newFavoriteRecipe.isFavorite = recipe.isFavorite
        newFavoriteRecipe.label = recipe.label
        newFavoriteRecipe.image = recipe.image
        newFavoriteRecipe.shareAs = recipe.shareAs
        newFavoriteRecipe.yield = recipe.yield ?? 0
        newFavoriteRecipe.ingredientLines = recipe.ingredientLines
        newFavoriteRecipe.calories = recipe.calories ?? 0
        newFavoriteRecipe.totalTime = recipe.totalTime ?? 0
        newFavoriteRecipe.cuisineType = recipe.cuisineType
        newFavoriteRecipe.mealType = recipe.mealType
        newFavoriteRecipe.instructions = recipe.instructions
        do {
            try saveData()
        } catch {
            throw error
        }
    }
    
    func removeFavoriteRecipe(recipe: Recipe) throws {
        do {
            if let label = recipe.label, let recipeToDelete = try fetchRecipe(withLabel: label) {
                cdManager.viewContext.delete(recipeToDelete)
                do {
                    try saveData()
                } catch {
                    throw error
                }
            }
        } catch {
            throw error
        }
    }
    
    func removeAllFavoriteRecipes() throws {
        let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        do {
            let favoriteRecipes = try cdManager.viewContext.fetch(request)
            for recipe in favoriteRecipes {
                cdManager.viewContext.delete(recipe)
            }
            do {
                try saveData()
            } catch {
                throw error
            }
        } catch {
            print("Error while retrieving CoreData data: \(error.localizedDescription)")
            throw error
        }
    }
    
    func updateFavoriteRecipes(recipe: Recipe) throws {
        do {
            if let label = recipe.label, let recipeToUpdate = try fetchRecipe(withLabel: label) {
                recipeToUpdate.isFavorite = recipe.isFavorite
                recipeToUpdate.label = recipe.label
                recipeToUpdate.image = recipe.image
                recipeToUpdate.shareAs = recipe.shareAs
                recipeToUpdate.yield = recipe.yield ?? 0
                recipeToUpdate.ingredientLines = recipe.ingredientLines
                recipeToUpdate.calories = recipe.calories ?? 0
                recipeToUpdate.totalTime = recipe.totalTime ?? 0
                recipeToUpdate.cuisineType = recipe.cuisineType
                recipeToUpdate.mealType = recipe.mealType
                recipeToUpdate.instructions = recipe.instructions
            }
        } catch {
            throw error
        }
    }
    
    
    // MARK: - Private functions
    private func fetchRecipe(withLabel: String) throws -> CDRecipe? {
        let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", withLabel as CVarArg)
        request.fetchLimit = 1
        do {
            let result: [CDRecipe]? = try cdManager.viewContext.fetch(request)
            return result?.first
        } catch {
            print("Error while retrieving CoreData data: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func saveData() throws {
        if cdManager.viewContext.hasChanges {
            do {
                try cdManager.viewContext.save()
            } catch {
                print("Error while saving Coredata data: \(error.localizedDescription)")
                throw error
            }
        }
    }
    
}
