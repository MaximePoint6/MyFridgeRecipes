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
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: viewModel.recipe.getRecipeImageUrl)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                VStack(alignment: .leading) {
                    Text(viewModel.recipe.getTitleRecipe)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .lineLimit(2)
                    Text(viewModel.recipe.getMealType + " • " + viewModel.recipe.getCuisineType)
                        .foregroundColor(Color.white.opacity(0.6))
                        .font(.caption)
                }
                .padding()
            }
            HStack(alignment: .center) {
            Spacer()
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("share".localized())
                }
                Spacer()
                HStack {
                    FavoriteButtonView(isLiked: $viewModel.isFavorite, action: viewModel.clickedOnIsfavorite, onColor: .red, offColor: .gray)
                    Text("favoris".localized())
                }
                Spacer()
            }
            .padding()
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundColor(.accentColor)
                HStack {
                    Spacer()
                    IconAndDataView(icon: "timer", data: viewModel.recipe.getPreparationTime, subtitle: "preparation".localized())
                    Spacer()
                    IconAndDataView(icon: "flame", data: viewModel.recipe.getCalories, subtitle: "per.portion".localized())
                    Spacer()
                }
                .padding()
            }
            if let ingredientLines = viewModel.recipe.ingredientLines, ingredientLines.count > 0 {
                Group {
                    VStack(alignment: .center, spacing: 5) {
                        Text("ingredients".localized())
                            .font(.title2)
                            .padding(.top, 10)
                        HStack(alignment: .center, spacing: 5) {
                            Text("for".localized())
                            HStack {
                                Text(viewModel.recipe.getPortionNumber)
                                Image(systemName: "fork.knife")
                            }
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    VStack(alignment: .leading) {
                        ForEach(ingredientLines, id: \.self) { ingredient in
                            Text("• " + ingredient)
                                .padding(1)
                        }
                    }
                    .padding()
                }
            }
            if let instructions = viewModel.recipe.instructions, instructions.count > 0 {
                Group {
                    Text("recipe".localized())
                        .font(.title2)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    VStack(alignment: .leading) {
                        ForEach(Array(instructions.enumerated()), id: \.offset) { (index, instruction) in
                            VStack {
                                Text("step".localized() + String(index))
                                    .font(.caption)
                                Text(instruction)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteButtonView(isLiked: $viewModel.isFavorite, action: viewModel.clickedOnIsfavorite, onColor: .red, offColor: .white)
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
