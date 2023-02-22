//
//  HomeView.swift
//  My fridge recipes
//
//  Created by Maxime Point on 20/01/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    @State private var searchText = ""
    @State private var timer: Timer?
    private let delay: TimeInterval = 1 // delay in seconds
    
    
    // MARK: - Main View
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 5) {
                TopBarView()
                SearchBarView(text: $searchText, keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
                Spacer()
                RecipesListView(pageState: $homeViewModel.pageState, loadNextRecipes: homeViewModel.fetchNextRecipesWithUrl, nextRecipesLoading: homeViewModel.nextRecipesLoading, sectionTitle: "recipe.ideas".localized())
                Spacer()
            }
        }
        .onChange(of: searchText) { newValue in
            // We add a delay before launching the request, to avoid making network calls at each change in the textField.
            self.timer?.invalidate() // Cancellation of the timer at each change.
            self.timer = Timer.scheduledTimer(withTimeInterval: self.delay, repeats: false, block: { _ in
                if searchText.isEmpty {
                    homeViewModel.fetchRandomRecipes()
                } else {
                    homeViewModel.fetchRecipeSearch(searchText: newValue)
                }
            })
        }
    }
}


// MARK: - Previews
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
