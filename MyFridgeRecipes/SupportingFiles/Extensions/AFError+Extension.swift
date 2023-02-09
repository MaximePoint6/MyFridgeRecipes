//
//  AFError+Extension.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 09/02/2023.
//

import Foundation
import Alamofire

extension AFError: Equatable {
    
    public static func==(lhs: AFError, rhs: AFError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}
