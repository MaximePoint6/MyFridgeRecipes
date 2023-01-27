//
//  RecipeDetailsView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        Text(viewModel.titleRecipe)
    }
}


// MARK: - Preview
struct RecipeDetailsView_Previews: PreviewProvider {
    static var viewModel = RecipeDetailsViewModel(recipe: MockData.previewSingleRecipe)
    
    static var previews: some View {
        RecipeDetailsView(viewModel: viewModel)
    }
}
