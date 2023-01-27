//
//  MyFridgeRecipesView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import SwiftUI

struct MyFridgeRecipesView: View {
    
    let recipes: [Recipes.Hit]
    
    var body: some View {
        VStack {
            List(recipes) { item in
                if let recipe = item.recipe {
                    NavigationLink {
                        RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
                    } label: {
                        RecipeCardView(viewModel: RecipeCardViewModel(recipe: recipe))
                    }
                }
            }
            Spacer()
        }
    }
}

struct MyFridgeRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyFridgeRecipesView(recipes: MockData.previewRecipes.hits!)
    }
}
