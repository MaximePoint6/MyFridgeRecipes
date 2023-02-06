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
    
    var body: some View {
        VStack {
            switch pageState {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error)
                case .loaded(let recipes):
                    List {
                        Section {
                            ForEach(recipes, id: \.label) { recipe in
                                NavigationLink {
                                    RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
                                } label: {
                                    RecipeCardView(viewModel: RecipeCardViewModel(recipe: recipe))
                                }
                                if recipe.label == recipes.last?.label {
                                    Text("")
                                    .onAppear(
                                        perform:
                                            loadNextRecipes
                                    )
                                }
                            }
                        } header: {
                            Text("recipe.ideas".localized())
                        }
                    }.listStyle(.insetGrouped)
                    if nextRecipesLoading {
                        ProgressView()
                    }
            }
        }
    }
}
    
    struct MyFridgeRecipesView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                RecipesListView(pageState: .constant(PageState.loaded(MockData.previewRecipeArray)), loadNextRecipes: {}, nextRecipesLoading: true)
                RecipesListView(pageState: .constant(PageState.loading), loadNextRecipes: {}, nextRecipesLoading: false)
                RecipesListView(pageState: .constant(PageState.failed(.noInternet)), loadNextRecipes: {}, nextRecipesLoading: false)
                RecipesListView(pageState: .constant(PageState.failed(.decoding)), loadNextRecipes: {}, nextRecipesLoading: false)
                RecipesListView(pageState: .constant(PageState.failed(.backend(400))), loadNextRecipes: {}, nextRecipesLoading: false)
            }
        }
    }
