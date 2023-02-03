//
//  RecipeDetailsView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    
    var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: viewModel.recipe.getRecipeImageUrl)!)
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(1), .clear]),
                    startPoint: .bottom,
                    endPoint: .top)
                    .frame(height: 150)
                Text(viewModel.recipe.getTitleRecipe)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
            }
            Text(viewModel.recipe.getMealType)
            Text(viewModel.recipe.getCuisineType)
            Text(viewModel.recipe.getCalories)
            List(viewModel.recipe.getIngredientLines, id: \.self) { ingredient in
                Text(ingredient)
            }
            List(viewModel.recipe.getInstructions, id: \.self) { instruction in
                Text(instruction)
            }
        }
    }
}


// MARK: - Preview
struct RecipeDetailsView_Previews: PreviewProvider {
    static var viewModel = RecipeDetailsViewModel(recipe: MockData.previewSingleRecipe)
    
    static var previews: some View {
        RecipeDetailsView(viewModel: viewModel)
    }
}
