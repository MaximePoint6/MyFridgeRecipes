//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation

struct Recipes: Codable {
    
    let from: Int?
    let to: Int?
    let count: Int? // number of recipes
    let _links: Links?
    let hits: [Hit]?
    
    struct Links: Codable {
//        let `self`: Link?
        let next: Link? // next page
    }
    
    struct Hit: Codable, Identifiable {
        let id = UUID()
        let recipe: Recipe?
//        let _links: Links?
    }
    
    struct Link: Codable {
        let href: String?
//        let title: String?
    }
    
    struct Recipe: Codable {
        //        let uri: String?
        let label: String?
        let image: String?
        let images: InlineModel1?
        //        let source: String?
        //        let url: String?
        let shareAs: String?
        //        let yield: Double?
        //        let dietLabels: [String]?
        //        let healthLabels: [String]?
        //        let cautions: [String]?
        let ingredientLines: [String]? // Ingrédient dans la recette
        let ingredients: [Ingredient]? // détails des aliments
        let calories: Double? // calories du plat
        let glycemicIndex: Double?
        let totalCO2Emissions: Double?
        let co2EmissionsClass: String?
        //        let totalWeight: Double?
        let totalTime: Double?
        let cuisineType: [String]?
        let mealType: [String]? // diner, lunch etc
        //        let dishType: [String]?
        let instructions: [String]?
        let tags: [String]?
        let externalId: String?
        let totalNutrients: NutrientsInfo?
        //        let totalDaily: NutrientsInfo?
        let digest: [DigestEntry]
    }
    
    struct InlineModel1: Codable {
        let thumbnail: ImageInfo?
        let small: ImageInfo?
        let regular: ImageInfo?
        let large: ImageInfo?
    }

    struct Ingredient: Codable {
        let text: String? // ligne des ingrédient (donc quantité + intitulé de l'ingrédient)
        let quantity: Double?
        let measure: String?
        let food: String?
        let weight: Double?
        //        let foodId: String?
    }

    struct NutrientsInfo: Codable {
        let enercKcal: NutrientsDetails // kcal
        let FAT: NutrientsDetails // lipide
        let PROCNT: NutrientsDetails // proteine
        let CHOCDF: NutrientsDetails // glucide
    }

    struct NutrientsDetails: Codable {
        let label: String
        let quantity: Double
        let unit: String
    }

    struct ImageInfo: Codable {
        let url: String?
        let width: Int?
        let height: Int?
    }

    struct DigestEntry: Codable {
        let label: String?
        let tag: String?
        //        let schemaOrgTag: String?
        let total: Double?
        //        let hasRDI: Bool?
        //        let daily: Double?
        let unit: String?
        let sub: [DigestEntry]?
    }
    
}
