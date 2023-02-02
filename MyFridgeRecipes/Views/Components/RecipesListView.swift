//
//  RecipesListView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import SwiftUI

struct RecipesListView: View {
    
    let pageState: PageState
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
                    Text("recipe.ideas".localized())
                    List(recipes) { recipe in
                        NavigationLink {
                            RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
                        } label: {
                            RecipeCardView(viewModel: RecipeCardViewModel(recipe: recipe))
                        }
                        if recipe.id == recipes.last?.id {
                            Text("")
                            .onAppear(
                                perform:
                                    loadNextRecipes
                            )
                        }
                    }
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
                RecipesListView(pageState: PageState.loaded(MockData.previewRecipeArray), loadNextRecipes: {}, nextRecipesLoading: true)
                RecipesListView(pageState: PageState.loading, loadNextRecipes: {}, nextRecipesLoading: false)
                RecipesListView(pageState: PageState.failed(.noInternet), loadNextRecipes: {}, nextRecipesLoading: false)
                RecipesListView(pageState: PageState.failed(.decoding), loadNextRecipes: {}, nextRecipesLoading: false)
                RecipesListView(pageState: PageState.failed(.backend(400)), loadNextRecipes: {}, nextRecipesLoading: false)
            }
        }
    }
