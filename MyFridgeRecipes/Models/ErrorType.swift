//
//  ErrorType.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import Foundation

enum ErrorType {
    case decoding
    case noInternet
    case backend(Int)
}
