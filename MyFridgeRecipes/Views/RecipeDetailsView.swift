//
//  RecipeDetailsView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    
    @ObservedObject var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottom) {
                VStack {
                    Rectangle()
                        .frame(height: 200)
                        .foregroundColor(.gray)
                    Spacer(minLength: 50)
                }
                KFImage(URL(string: viewModel.recipe.getRecipeImageUrl)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            Text(viewModel.recipe.getTitleRecipe)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Rectangle()
                .frame(width: 100, height: 10)
                .foregroundColor(.red)
            Text(viewModel.recipe.getMealType)
            Text(viewModel.recipe.getCuisineType)
            HStack {
                Spacer()
                Text("Partager")
                Spacer()
                FavoriteButtonView(isLiked: $viewModel.isFavorite, action: viewModel.clickedOnIsfavorite, onColor: .red, offColor: .gray)
                Spacer()
            }
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.red)
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "flame")
                        Text(viewModel.recipe.getPreparationTime)
                        Text("préparation")
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "flame")
                        Text(viewModel.recipe.getCalories)
                        Text("par plat")
                    }
                    Spacer()
                }
            }
            Group {
                Text("Ingredient")
                Text("Pour " + viewModel.recipe.getPortionNumber)
                    .padding()
                ForEach(viewModel.recipe.getIngredientLines, id: \.self) { ingredient in
                    Text(ingredient)
                }
            }
            Group {
                Text("Recette")
                    .padding()
                ForEach(viewModel.recipe.getInstructions, id: \.self) { instruction in
                    Text(instruction)
                }
            }
            
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteButtonView(isLiked: $viewModel.isFavorite, action: viewModel.clickedOnIsfavorite, onColor: .red, offColor: .gray)
            }
        }
        .onAppear {
            viewModel.checkIfIsfavorite()
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
