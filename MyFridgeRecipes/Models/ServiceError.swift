//
//  ServiceError.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 20/01/2023.
//

import Foundation

enum ServiceError: String, Error {
    case urlNotCorrect
    case noData
    case badResponse
    case undecodableJSON
}
