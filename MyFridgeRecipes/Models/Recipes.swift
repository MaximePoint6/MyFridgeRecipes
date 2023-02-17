//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    let _links: Links?
    let hits: [Hit]?
    
    struct Links: Codable {
        let next: Link? // next page
    }
    
    struct Hit: Codable {
        let recipe: Recipe?
    }
    
    struct Link: Codable {
        let href: String?
    }
}


// MARK: - Recipe
struct Recipe: Codable {
    var isFavorite: Bool
    let label: String?
    let image: String?
    let shareAs: String?
    let yield: Double? // Recipe for x person
    let ingredientLines: [String]? // Ingrédient dans la recette
    let calories: Double? // calories du plat
    let totalTime: Double?
    let cuisineType: [String]?
    let mealType: [String]? // diner, lunch etc
    let instructions: [String]?
    //        let tags: [String]?
    //        let totalNutrients: NutrientsInfo?
    //        let totalDaily: NutrientsInfo?
    //        let digest: [DigestEntry]?
    
    enum CodingKeys: String, CodingKey {
        case isFavorite
        case label
        case image
        case shareAs
        case yield
        case ingredientLines
        case calories
        case totalTime
        case cuisineType
        case mealType
        case instructions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        image = try container.decode(String.self, forKey: .image)
        shareAs = try container.decodeIfPresent(String.self, forKey: .shareAs)
        yield = try container.decode(Double.self, forKey: .yield)
        ingredientLines = try container.decode([String].self, forKey: .ingredientLines)
        calories = try container.decodeIfPresent(Double.self, forKey: .calories)
        totalTime = try container.decode(Double.self, forKey: .totalTime)
        cuisineType = try container.decode([String].self, forKey: .cuisineType)
        mealType = try container.decodeIfPresent([String].self, forKey: .mealType)
        instructions = try container.decodeIfPresent([String].self, forKey: .instructions)
        // Here decode a other property and if not present set default value
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
}

extension Recipe {
    // MARK: - UI
    var getRecipeImageUrl: String {
        return self.image ?? "-"
    }
    
    var getTitleRecipe: String {
        return self.label ?? "-"
    }
    
    var getCalories: String {
        guard let calories = self.calories, calories > 0 else {
            return "- " + "kcal".localized()
        }
        guard let portions = self.yield, portions > 0 else {
            return String(format: "kcals".localized(), calories)
        }
        return String(format: "kcals".localized(), calories/portions)
    }
    
    var getPortionNumber: String {
        guard let portions = self.yield, portions > 0 else {
            return "-"
        }
        return String(Int(portions))
    }
    
    var getPreparationTime: String {
        guard let preparationTime = self.totalTime, preparationTime > 0 else {
            return "- " + "minute".localized()
        }
        return String(format: "minutes".localized(), preparationTime)
    }
    
    var getCuisineType: String {
        return self.cuisineType?.compactMap { $0 }.joined(separator: " - ") ?? ""
    }
    
    var getMealType: String {
        return self.mealType?.compactMap { $0 }.joined(separator: " - ") ?? ""
    }
    
    var getShareURL: URL? {
        guard let urlString = self.shareAs else { return nil }
        return URL(string: urlString)
    }
}
