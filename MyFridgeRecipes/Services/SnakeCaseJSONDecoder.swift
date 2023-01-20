//
//  SnakeCaseJSONDecoder.swift
//  My fridge recipes
//
//  Created by Maxime Point on 20/01/2023.
//

import Foundation

/// Allows to decode, for example, a JSON file with SnakeCase format.
class SnakeCaseJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
