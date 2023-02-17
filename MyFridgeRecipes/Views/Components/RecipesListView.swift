//
//  RecipesListView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import SwiftUI

struct RecipesListView: View {
    
    @Binding var pageState: PageState
    let loadNextRecipes: () -> Void
    let nextRecipesLoading: Bool
    let sectionTitle: String
    
    // MARK: - Main View
    var body: some View {
        VStack(alignment: .center) {
            switch pageState {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error)
                case .loaded(let recipes):
                    if recipes.isEmpty {
                        Spacer()
                        Text("no.recipe".localized())
                        Spacer()
                    } else {
                        List {
                            Section {
                                ForEach(recipes, id: \.label) { recipe in
                                    NavigationLink {
                                        RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
                                    } label: {
                                        RecipeCardView(viewModel: RecipeCardViewModel(recipe: recipe))
                                    }
                                    .accessibilityHint(Text("navigate.to.recipe.details"))
                                    if recipe.label == recipes.last?.label {
                                        EmptyView()
                                            .onAppear(
                                                perform:
                                                    loadNextRecipes
                                            )
                                            .accessibility(hidden: true)
                                    }
                                }
                            } header: {
                                Text(sectionTitle)
                                    .accessibilityLabel("recipe.list.including".localized() + sectionTitle)
                            }
                        }
                        .listStyle(PlainListStyle())
                        if nextRecipesLoading {
                            ProgressView()
                        }
                    }
            }
        }
    }
}

// MARK: - Preview
struct MyFridgeRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipesListView(pageState: .constant(PageState.loaded(MockData.previewRecipeArray)), loadNextRecipes: {}, nextRecipesLoading: false, sectionTitle: "recipe.ideas".localized())
            RecipesListView(pageState: .constant(PageState.loaded([])), loadNextRecipes: {}, nextRecipesLoading: false, sectionTitle: "recipe.ideas".localized())
            RecipesListView(pageState: .constant(PageState.loading), loadNextRecipes: {}, nextRecipesLoading: false, sectionTitle: "recipe.ideas".localized())
            RecipesListView(pageState: .constant(PageState.failed(.noInternet)), loadNextRecipes: {}, nextRecipesLoading: false, sectionTitle: "recipe.ideas".localized())
            RecipesListView(pageState: .constant(PageState.failed(.decoding)), loadNextRecipes: {}, nextRecipesLoading: false, sectionTitle: "recipe.ideas".localized())
            RecipesListView(pageState: .constant(PageState.failed(.backend(400))), loadNextRecipes: {}, nextRecipesLoading: false, sectionTitle: "recipe.ideas".localized())
        }
    }
}
