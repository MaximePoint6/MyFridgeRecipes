//
//  MyTabView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct MyTabView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Fridge", systemImage: "magnifyingglass")
                }
            FavoriteView()
                .tabItem {
                    Label("Favorite", systemImage: "heart.fill")
                }
        }
    }
}


// MARK: - Preview
struct TabView_Previews: PreviewProvider {
    @StateObject static var viewModel = HomeViewModel()
    
    static var previews: some View {
        MyTabView()
            .environmentObject(viewModel)
    }
}
