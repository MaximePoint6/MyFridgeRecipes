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
                    Label("home".localized(), systemImage: "house")
                }
            FridgeView()
                .tabItem {
                    Label("my.fridge".localized(), systemImage: "snowflake")
                }
            FavouritesView()
                .tabItem {
                    Label("my.favourites".localized(), systemImage: "heart.fill")
                }
        }
    }
}


// MARK: - Preview
struct TabView_Previews: PreviewProvider {
    @StateObject static var topBarViewModel = TopBarViewModel()
    
    static var previews: some View {
        MyTabView()
            .environmentObject(topBarViewModel)
    }
}
