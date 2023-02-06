//
//  FavoritesView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var topBarViewModel: TopBarViewModel
    @StateObject var viewModel = FavoritesViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TopBarView(viewModel: topBarViewModel)
                SearchBarView(text: $searchText, keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
                Spacer()
                RecipesListView(pageState: $viewModel.pageState, loadNextRecipes: {}, nextRecipesLoading: false)
            }
        }
        .onChange(of: searchText) { newValue in
            if searchText.isEmpty {
                viewModel.getFavoriteRecipes()
            } else {
                viewModel.getDesiredRecipes(searchText: newValue)
            }
        }
        .onAppear {
            viewModel.getFavoriteRecipes()
        }
    }
}


// MARK: - Preview
struct FavoriteView_Previews: PreviewProvider {
    @StateObject static var topBarViewModel = TopBarViewModel()
    @StateObject var viewModel = FavoritesViewModel()
    
    static var previews: some View {
        FavoritesView()
            .environmentObject(topBarViewModel)
    }
}
