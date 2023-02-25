//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation

// MARK: - Recipes
struct Recipes: Decodable {
    let _links: Links?
    let hits: [Hit]?
    
    struct Links: Decodable {
        let next: Link? // recipe next page
    }
    
    struct Hit: Decodable {
        let recipe: Recipe?
    }
    
    struct Link: Decodable {
        let href: String?
    }
}
