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
    
    // MARK: - Main View
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    titleSection
                    SearchBarView(text: $searchText, keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
                }
                Spacer()
                RecipesListView(pageState: $viewModel.pageState, loadNextRecipes: {}, nextRecipesLoading: false, sectionTitle: "favorite.recipes".localized())
            }
        }
        .onChange(of: searchText) { newValue in
            if searchText.isEmpty {
                viewModel.updateFavoriteRecipes()
            } else {
                viewModel.getFilteredRecipes(searchText: newValue)
            }
        }
        .alert(isPresented: $viewModel.coreDataError) {
            Alert(title: Text("CoreData Error"), message: Text("Il y a eu une erreur avec CoreData."))
        }
    }
    
    
    // MARK: - SUbviews
    var titleSection: some View {
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
