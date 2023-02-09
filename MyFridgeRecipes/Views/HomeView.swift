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
    @State private var isEditing = false
    @State private var timer: Timer?
    private let delay: TimeInterval = 1 // delay in seconds
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                    .gesture(
                        TapGesture().onEnded {
                            if self.isEditing {
                                UIApplication.shared.endEditing()
                                self.isEditing = false
//                            } else {
//                                self.isEditing = false
                            }
                        }
                    )
                VStack {
                    TopBarView(viewModel: topBarViewModel)
                    SearchBarView(text: $searchText, isEditing: $isEditing, keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
                    Spacer()
                    RecipesListView(pageState: $homeViewModel.pageState, loadNextRecipes: homeViewModel.fetchNextRecipesWithUrl, nextRecipesLoading: homeViewModel.nextRecipesLoading)
                    Spacer()
                }
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
