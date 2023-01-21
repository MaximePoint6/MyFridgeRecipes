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
    let count: Int?
    let _links: Links?
    let hits: [Hit]?
    
    struct Links: Codable {
        let `self`: Link?
        let next: Link?
    }
    
    struct Hit: Codable {
        let recipe: Recipe?
        let _links: Links?
    }
    
    struct Link: Codable {
        let href: String?
        let title: String?
    }
    
    struct Recipe: Codable {
        let uri: String?
        let label: String?
        let image: String?
        let images: InlineModel1?
        let source: String?
        let url: String?
        let shareAs: String?
        let yield: Double?
        let dietLabels: [String]?
        let healthLabels: [String]?
        let cautions: [String]?
        let ingredientLines: [String]?
        let ingredients: [Ingredient]?
        let calories: Double?
        let glycemicIndex: Double?
        let totalCO2Emissions: Double?
        let co2EmissionsClass: String?
        let totalWeight: Double?
        let cuisineType: [String]?
        let mealType: [String]?
        let dishType: [String]?
        let instructions: [String]?
        let tags: [String]?
        let externalId: String?
        let totalNutrients: NutrientsInfo?
        let totalDaily: NutrientsInfo?
        let digest: [DigestEntry]
    }
    
    struct InlineModel1: Codable {
        let thumbnail: ImageInfo?
        let small: ImageInfo?
        let regular: ImageInfo?
        let large: ImageInfo?
    }
    
    struct Ingredient: Codable {
        let text: String?
        let quantity: Double?
        let measure: String?
        let food: String?
        let weight: Double?
        let foodId: String?
    }
    
    struct NutrientsInfo: Codable {
    }
    
    struct ImageInfo: Codable {
        let url: String?
        let width: Int?
        let height: Int?
    }
    
    struct DigestEntry: Codable {
        let label: String?
        let tag: String?
        let schemaOrgTag: String?
        let total: Double?
        let hasRDI: Bool?
        let daily: Double?
        let unit: String?
//        let sub: Digest?
    }
    
}
