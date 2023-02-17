//
//  RecipeCardView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI
import Kingfisher

struct RecipeCardView: View {
    
    @ObservedObject var viewModel: RecipeCardViewModel
    
    // MARK: - Main View
    var body: some View {
        HStack {
            cardImage
            cardText
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Subviews
    var cardImage: some View {
        KFImage(viewModel.recipe.getRecipeImageUrl)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 130, height: 80)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 0.2)
            )
            .padding(.trailing, 10)
            .accessibilityLabel(Text("recipe.picture".localized()))
    }
    
    var cardText: some View {
        VStack(alignment: .leading) {
            Text(viewModel.recipe.getTitleRecipe)
                .font(.title2)
                .lineLimit(2)
            Text(viewModel.recipe.getMealType + " • " + viewModel.recipe.getCuisineType)
                .font(.caption)
                .lineLimit(1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("recipe.name".localized() + viewModel.recipe.getTitleRecipe + ". " + "meal.type".localized() + viewModel.recipe.getMealType + ". " + "cuisine.type".localized() + viewModel.recipe.getCuisineType)
    }
}


// MARK: - Preview
struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(viewModel: RecipeCardViewModel(recipe: MockData.previewSingleRecipe))
            .previewLayout(.sizeThatFits)
    }
}
