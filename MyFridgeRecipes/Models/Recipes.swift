//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation

struct Recipes: Codable {
    
//    let from: Int?
//    let to: Int?
//    let count: Int? // number of recipes
    let _links: Links?
    let hits: [Hit]?
    
    struct Links: Codable {
//        let `self`: Link?
        let next: Link? // next page
    }
    
    struct Hit: Codable {
        let recipe: Recipe?
//        let _links: Links?
    }
    
    struct Link: Codable {
        let href: String?
//        let title: String?
    }
    
    struct Recipe: Codable {
        var isFavorite: Bool
        let label: String?
        let image: String?
        let shareAs: String?
        let yield: Double? // Recipe for x person
//        let dietLabels: [String]?
//        let healthLabels: [String]?
//        let cautions: [String]?
        let ingredientLines: [String]? // Ingrédient dans la recette
//        let ingredients: [Ingredient]? // détails des aliments
        let calories: Double? // calories du plat
//        let glycemicIndex: Double?
//        let totalWeight: Double?
        let totalTime: Double?
        let cuisineType: [String]?
        let mealType: [String]? // diner, lunch etc
//        let dishType: [String]?
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
        
        // MARK: - UI
        var getRecipeImageUrl: String {
            return self.image ?? "-"
        }
        
        var getTitleRecipe: String {
            return self.label ?? "-"
        }
        
        var getCalories: String {
            guard let calories = self.calories else {
                return "- " + "kcals".localized()
            }
            return (String(Int(calories)) + " " + "kcals".localized())
        }
        
        var getPortionNumber: String {
            guard let portionNumber = self.yield else {
                return "- "
            }
            return String(Int(portionNumber))
        }
        
        var getPreparationTime: String {
            guard let preparationTime = self.totalTime else {
                return "- " + "minutes".localized()
            }
            return (String(Int(preparationTime)) + " " + "minutes".localized())
        }

        var getCuisineType: String {
            return self.cuisineType?.compactMap { $0 }.joined(separator: " - ") ?? ""
        }
        
        var getMealType: String {
            return self.mealType?.compactMap { $0 }.joined(separator: " - ") ?? ""
        }
        
    }
    
//    struct InlineModel1: Codable {
//        let thumbnail: ImageInfo?
//        let small: ImageInfo?
//        let regular: ImageInfo?
//        let large: ImageInfo?
//    }

//    struct Ingredient: Codable {
//        let text: String? // ligne des ingrédient (donc quantité + intitulé de l'ingrédient)
//        let quantity: Double?
//        let measure: String?
//        let food: String?
//        let weight: Double?
//        //        let foodId: String?
//    }

//    struct NutrientsInfo: Codable {
//        let enercKcal: NutrientsDetails? // kcal
//        let FAT: NutrientsDetails? // lipide
//        let PROCNT: NutrientsDetails? // proteine
//        let CHOCDF: NutrientsDetails? // glucide
//    }

//    struct NutrientsDetails: Codable {
//        let label: String?
//        let quantity: Double?
//        let unit: String?
//    }

//    struct ImageInfo: Codable {
//        let url: String?
//        let width: Int?
//        let height: Int?
//    }

//    struct DigestEntry: Codable {
//        let label: String?
//        let tag: String?
//        //        let schemaOrgTag: String?
//        let total: Double?
//        //        let hasRDI: Bool?
//        //        let daily: Double?
//        let unit: String?
//        let sub: [DigestEntry]?
//    }
    
}
