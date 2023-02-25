//
//  Recipe.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 25/02/2023.
//

import Foundation

// MARK: - Recipe
struct Recipe: Decodable {
    var isFavorite: Bool
    let label: String?
    let image: String?
    let url: String?
    let shareAs: String? // share link
    let yield: Double? // number of portions in recipe
    let ingredientLines: [String]?
    let calories: Double? // calories of dish
    let totalTime: Double?
    let cuisineType: [String]?
    let mealType: [String]? // diner, lunch ...
    let instructions: [String]?
    
    enum CodingKeys: String, CodingKey {
        case isFavorite
        case label
        case image
        case url
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
        url = try container.decode(String.self, forKey: .url)
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
    
    init?(fromCoreDataObject coreDataObject: CDRecipe) {
        self.isFavorite = coreDataObject.isFavorite
        self.label = coreDataObject.label
        self.image = coreDataObject.image
        self.url = coreDataObject.url
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

// MARK: - Properties used for UI
extension Recipe {
    
    /// To get recipe image url.
    var getImageUrl: URL {
        guard let urlString = self.image else {
            return URL(string: "https://cdn.pixabay.com/photo/2015/10/26/07/21/vegetables-1006694_960_720.jpg")!
        }
        return URL(string: urlString)!
    }
    
    /// To get recipe source url.
    var getSourceUrl: URL? {
        guard let urlString = self.url else { return nil }
        return URL(string: urlString)
    }
    
    /// To get recipe title.
    var getTitle: String {
        return self.label ?? "-"
    }
    
    /// To get calories (per portion if available, otherwise per dish).
    var getCalories: String {
        guard let calories = self.calories, calories > 0 else {
            return "- " + "kcal".localized()
        }
        guard let portions = self.yield, portions > 0 else {
            return String(format: "kcals".localized(), calories)
        }
        return String(format: "kcals".localized(), calories/portions)
    }
    
    /// To get portion number.
    var getPortionNumber: String {
        guard let portions = self.yield, portions > 0 else {
            return "-"
        }
        return String(Int(portions))
    }
    
    /// To get preparation time (in minutes).
    var getPreparationTime: String {
        guard let preparationTime = self.totalTime, preparationTime > 0 else {
            return "- " + "minute".localized()
        }
        return String(format: "minutes".localized(), preparationTime)
    }
    
    /// To get cuisine type.
    var getCuisineType: String {
        return self.cuisineType?.compactMap { $0 }.joined(separator: " - ") ?? ""
    }
    
    /// To get meal type.
    var getMealType: String {
        return self.mealType?.compactMap { $0 }.joined(separator: " - ") ?? ""
    }
    
    /// To get share URL.
    var getShareURL: URL? {
        guard let urlString = self.shareAs else { return nil }
        return URL(string: urlString)
    }
}

