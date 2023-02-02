//
//  RecipesListView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import SwiftUI

struct RecipesListView: View {
    
    let recipes: [Recipes.Recipe]
    
    var body: some View {
        VStack {
            List(recipes) { recipe in
                    NavigationLink {
                        RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
                    } label: {
                        RecipeCardView(viewModel: RecipeCardViewModel(recipe: recipe))
                    }
            }
            Spacer()
        }
    }
}

struct MyFridgeRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView(recipes: MockData.previewRecipeArray)
    }
}
