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
    @State private var onCommit = false
    @State private var timer: Timer?
    private let delay: TimeInterval = 1 // delay in seconds
    
    var body: some View {
        NavigationView {
            VStack {
                TopBarView(viewModel: topBarViewModel)
                SearchBarView(text: $searchText, keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
                Spacer()
                switch homeViewModel.pageState {
                    case .loading:
                        ProgressView()
                    case .failed(let error):
                        ErrorView(error: error)
                    case .loaded(let recipes):
                        Text("recipe.ideas".localized())
                        List(recipes) { item in
                            if let recipe = item.recipe {
                                NavigationLink {
                                    RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
                                } label: {
                                    RecipeCardView(viewModel: RecipeCardViewModel(recipe: recipe))
                                }
                            }
                        }
                }
                Spacer()
                if homeViewModel.nextRecipesLoading {
                    ProgressView()
                } else {
                    Button {
                        homeViewModel.fetchNextRecipesWithUrl()
                    } label: {
                        Text("more.recipes".localized())
                    }
                }
            }
        }
        // To avoid making network calls at each change in the textField, we add a delay before launching the request.
        .onChange(of: searchText) { newValue in
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: self.delay, repeats: false, block: { _ in
                homeViewModel.fetchRecipeSearch(searchText: newValue)
            })
        }

    }
}


// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    
    @StateObject static var topBarViewModel = TopBarViewModel()
    
    static var previews: some View {
        HomeView()
            .environmentObject(topBarViewModel)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
