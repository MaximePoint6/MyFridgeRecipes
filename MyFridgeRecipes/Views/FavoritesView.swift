//
//  FavoritesView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: FavoritesViewModel
    @State private var searchText = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("all.favorites.recipes".localized())
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Text("available.offline".localized())
                            .font(.caption)
                            .foregroundColor(.accentColor)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top, 5)
                .padding(.bottom, 5)
                SearchBarView(text: $searchText, isEditing: $isEditing, keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
                }
                Spacer()
                RecipesListView(pageState: $viewModel.pageState, loadNextRecipes: {}, nextRecipesLoading: false)
            }
        }
        .onChange(of: searchText) { newValue in
            if searchText.isEmpty {
                viewModel.updateFavoriteRecipes()
            } else {
                viewModel.getFilteredRecipes(searchText: newValue)
            }
        }
    }
}


// MARK: - Preview
struct FavoriteView_Previews: PreviewProvider {
    @StateObject static var topBarViewModel = TopBarViewModel()
    @StateObject static var viewModel = FavoritesViewModel()
    
    static var previews: some View {
        FavoritesView()
            .environmentObject(topBarViewModel)
            .environmentObject(viewModel)
    }
}
