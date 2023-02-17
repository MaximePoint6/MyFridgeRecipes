//
//  HomeView.swift
//  My fridge recipes
//
//  Created by Maxime Point on 20/01/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @EnvironmentObject var topBarViewModel: TopBarViewModel
    @StateObject var homeViewModel = HomeViewModel()
    @State private var searchText = ""
    @State private var timer: Timer?
    @State private var shoulShowOnBoarding = true
    private let delay: TimeInterval = 1 // delay in seconds
    
    
    // MARK: - Main View
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 5) {
                SimpleTopBar(viewModel: topBarViewModel)
                SearchBarView(text: $searchText, keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
                Spacer()
                RecipesListView(pageState: $homeViewModel.pageState, loadNextRecipes: homeViewModel.fetchNextRecipesWithUrl, nextRecipesLoading: homeViewModel.nextRecipesLoading, sectionTitle: "recipe.ideas".localized())
                Spacer()
            }
        }
        // To avoid making network calls at each change in the textField, we add a delay before launching the request.
        .onChange(of: searchText) { newValue in
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: self.delay, repeats: false, block: { _ in
                if searchText.isEmpty {
                    homeViewModel.fetchRandomRecipes()
                } else {
                    homeViewModel.fetchRecipeSearch(searchText: newValue)
                }
            })
        }
        .fullScreenCover(isPresented: $shoulShowOnBoarding) {
            OnBoardingView(shoulShowOnBoarding: $shoulShowOnBoarding)
        }
        
    }
}


// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    @StateObject static var topBarViewModel = TopBarViewModel()
    static var previews: some View {
        HomeView()
            .environmentObject(topBarViewModel)
    }
}
