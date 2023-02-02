//
//  PageState.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 02/02/2023.
//

import Foundation

enum PageState {
    case loading
    case failed(ErrorManager.ErrorType)
    case loaded([Recipes.Recipe])
}
