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
    @EnvironmentObject var favoriteViewModel: FavoritesViewModel
    
    // MARK: - Main View
    var body: some View {
        ScrollView {
            headerSection
            shareAndFavoritesButtonSection
            recipeDataSection
            ingredientSection
            instructionsSection
        }
        .ignoresSafeArea(.container, edges: .top)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteButtonView(isLiked: $viewModel.recipe.isFavorite, action: viewModel.clickedOnIsfavorite, onColor: .accentColor, offColor: .white)
            }
        }
        .onAppear {
            viewModel.setupFavoritesViewModel(favoritesViewModel: favoriteViewModel)
            viewModel.checkIfIsfavorite()
        }
        .alert(isPresented: $viewModel.coreDataError) {
            Alert(title: Text("error".localized()), message: Text("save.problem"), dismissButton: .cancel())
        }
    }
    
    
    // MARK: - Subviews
    var headerSection: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(viewModel.recipe.getImageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()
                .accessibilityLabel(Text("recipe.picture".localized()))
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack(alignment: .leading) {
                Text(viewModel.recipe.getTitle)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .lineLimit(2)
                Text(viewModel.recipe.getMealType + " • " + viewModel.recipe.getCuisineType)
                    .foregroundColor(Color.white.opacity(0.6))
                    .font(.caption)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("recipe.name".localized() + viewModel.recipe.getTitle + ". " + "meal.type".localized() + viewModel.recipe.getMealType + ". " + "cuisine.type".localized() + viewModel.recipe.getCuisineType)
            .padding()
        }
    }
    
    var shareAndFavoritesButtonSection: some View {
        HStack(alignment: .center) {
            if let shareURL = viewModel.recipe.getShareURL {
                Spacer()
                    Button {
                        viewModel.share(this: [shareURL])
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .accessibility(hidden: true)
                            Text("share".localized())
                                .accessibility(hidden: true)
                        }
                    }
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("share".localized())
                    .accessibility(hint: Text("share.recipe".localized()))
            }
            Spacer()
            HStack {
                FavoriteButtonView(isLiked: $viewModel.recipe.isFavorite, action: viewModel.clickedOnIsfavorite, onColor: .accentColor, offColor: .gray)
                Text("favoris".localized())
                    .accessibility(hidden: true)
            }
            Spacer()
        }
        .padding()
    }
    
    var recipeDataSection: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(.accentColor)
            HStack {
                Spacer()
                IconAndDataView(icon: "timer", data: viewModel.recipe.getPreparationTime, subtitle: "preparation".localized())
                Spacer()
                IconAndDataView(icon: "flame", data: viewModel.recipe.getCalories, subtitle: viewModel.recipe.getPortionNumber != "-" ? "per.portion".localized() : "per.dish".localized())
                Spacer()
            }
            .padding()
        }
    }
    
    @ViewBuilder // By using @ViewBuilder the compiler understands that this function may or may not return a view depending on the content. Here, if there is no ingredientLine, the function will not return a view. If the ingredients are present, it will return a view that displays them.
    var ingredientSection: some View {
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
                                .accessibility(hidden: true)
                        }
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(String(format: "for.x.people".localized(), viewModel.recipe.getPortionNumber))
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
    }
    
    @ViewBuilder
    var instructionsSection: some View {
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
    
    
}


// MARK: - Preview
struct RecipeDetailsView_Previews: PreviewProvider {
    @StateObject static var favoriteViewModel = FavoritesViewModel()
    static var viewModel = RecipeDetailsViewModel(recipe: MockData.previewSingleRecipe)
    static var previews: some View {
        RecipeDetailsView(viewModel: viewModel)
            .environmentObject(favoriteViewModel)
    }
}
