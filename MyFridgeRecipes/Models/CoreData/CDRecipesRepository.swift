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
    func getFavoriteRecipes(completion: ([Recipes.Recipe]) -> Void) {
        let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        do {
            let favoriteRecipes = try cdManager.viewContext.fetch(request)
            let recipes = favoriteRecipes.compactMap({ (rawRecipe: CDRecipe) -> Recipes.Recipe? in
                Recipes.Recipe(fromCoreDataObject: rawRecipe)
            })
            completion(recipes)
        } catch {
            print("Error while retrieving CoreData data: \(error.localizedDescription)")
            completion([])
        }
    }
    
    func addFavoriteRecipes(recipe: Recipes.Recipe) {
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
        saveData()
//        do {
//            try cdManager.viewContext.save()
//            completion()
//        } catch {
//            print("We were unable to save \(recipe.label ?? "recipe"). Error : \(error.localizedDescription)")
//        }
    }
    
    func removeFavoriteRecipe(recipe: Recipes.Recipe) {
        if let label = recipe.label, let recipeToDelete = fetchCDRecipe(withLabel: label) {
            cdManager.viewContext.delete(recipeToDelete)
            saveData()
        }
    }
    
    func removeAllFavoriteRecipes() {
        let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        do {
            let favoriteRecipes = try cdManager.viewContext.fetch(request)
            
            for recipe in favoriteRecipes {
                cdManager.viewContext.delete(recipe)
            }
            saveData()
        } catch {
            print("Error while retrieving CoreData data: \(error.localizedDescription)")
        }
    }
    
    func updateFavoriteRecipes(recipe: Recipes.Recipe) {
        if let label = recipe.label, let recipeToDelete = fetchCDRecipe(withLabel: label) {
            recipeToDelete.isFavorite = recipe.isFavorite
            recipeToDelete.label = recipe.label
            recipeToDelete.image = recipe.image
            recipeToDelete.shareAs = recipe.shareAs
            recipeToDelete.yield = recipe.yield ?? 0
            recipeToDelete.ingredientLines = recipe.ingredientLines
            recipeToDelete.calories = recipe.calories ?? 0
            recipeToDelete.totalTime = recipe.totalTime ?? 0
            recipeToDelete.cuisineType = recipe.cuisineType
            recipeToDelete.mealType = recipe.mealType
            recipeToDelete.instructions = recipe.instructions
        }
    }
    
    private func fetchCDRecipe(withLabel: String) -> CDRecipe? {
        let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", withLabel as CVarArg)
        request.fetchLimit = 1
        let result: [CDRecipe]? = try? cdManager.viewContext.fetch(request)
        return result?.first
    }
    
    
    private func saveData() {
        if cdManager.viewContext.hasChanges {
            do {
                try cdManager.viewContext.save()
            } catch {
                print("Error during CoreData backup: \(error.localizedDescription)")
            }
        }
    }
    
}



extension Recipes.Recipe {
    init?(fromCoreDataObject coreDataObject: CDRecipe) {
//        guard let label = coreDataObject.label,
//              let image = coreDataObject.image,
//              let shareAs = coreDataObject.shareAs,
//              let ingredientLines = coreDataObject.ingredientLines,
//              let cuisineType = coreDataObject.cuisineType,
//              let mealType = coreDataObject.mealType,
//              let instructions = coreDataObject.instructions else {
//            return nil
//        }
        self.isFavorite = coreDataObject.isFavorite
        self.label = coreDataObject.label
        self.image = coreDataObject.image
        self.shareAs = coreDataObject.shareAs
        self.yield = coreDataObject.yield
        self.ingredientLines = coreDataObject.ingredientLines
        self.calories = coreDataObject.calories
        self.totalTime = coreDataObject.totalTime
        self.cuisineType = coreDataObject.cuisineType
        self.mealType = coreDataObject.mealType
        self.instructions = coreDataObject.instructions
    }
}
