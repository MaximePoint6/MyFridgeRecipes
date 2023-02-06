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
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                KFImage(URL(string: viewModel.recipe.getRecipeImageUrl)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 80)
                   .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 0.2)
                    )
                .padding(.trailing, 10)
            }
            VStack(alignment: .leading) {
                Text(viewModel.recipe.getTitleRecipe)
                    .font(.title2)
                    .lineLimit(2)
                Text(viewModel.recipe.getCuisineType)
                    .font(.headline)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
    }
}


// MARK: - Preview
struct RecipeCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeCardView(viewModel: RecipeCardViewModel(recipe: MockData.previewSingleRecipe))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}
