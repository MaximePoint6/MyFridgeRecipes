//
//  RecipeCardView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI
import Kingfisher

struct RecipeCardView: View {
    
    let viewModel: RecipeCardViewModel
    
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
    private var cardImage: some View {
        KFImage(viewModel.recipe.getImageUrl)
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
    
    private var cardText: some View {
        VStack(alignment: .leading) {
            Text(viewModel.recipe.getTitle)
                .font(.title2)
                .lineLimit(2)
            Text(viewModel.recipe.getMealType + " • " + viewModel.recipe.getCuisineType)
                .font(.caption)
                .lineLimit(1)
                .foregroundColor(Color.primary.opacity(0.6))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("recipe.name".localized() + viewModel.recipe.getTitle + ". " + "meal.type".localized() + viewModel.recipe.getMealType + ". " + "cuisine.type".localized() + viewModel.recipe.getCuisineType)
    }
}


// MARK: - Previews
struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(viewModel: RecipeCardViewModel(recipe: MockData.previewSingleRecipe))
            .previewLayout(.sizeThatFits)
    }
}
