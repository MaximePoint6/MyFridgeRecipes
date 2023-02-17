//
//  Language.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 20/01/2023.
//

import Foundation

enum Language: String, CaseIterable, Codable {
    case en
    case fr
    
    /// Returns the language name
    var description: String {
        switch self {
            case .en: return "English"
            case .fr: return "Français"
        }
    }
}
