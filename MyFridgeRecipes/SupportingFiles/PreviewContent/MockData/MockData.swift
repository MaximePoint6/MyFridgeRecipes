//
//  MockData.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import Foundation

class MockData {
    
    // Mock datas
    static var previewSingleRecipe: Recipe = load("Recipe.json")
    static var previewRecipes: Recipes = load("Recipes.json")
    static var previewRecipeArray: [Recipe] = previewRecipes.hits!
        .filter { $0.recipe != nil }
        .map { $0.recipe! }
    
    /// To load a JSON file, decode it and return an object of generic type T.
    /// - Parameter filename: filename.
    /// - Returns: object of generic type T.
    static private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = SnakeCaseJSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
}
