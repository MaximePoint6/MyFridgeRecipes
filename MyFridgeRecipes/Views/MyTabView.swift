//
//  MyTabView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct MyTabView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    @AppStorage(AppStorageKeys.OnBoardingViewShouldAppear.rawValue) var OnBoardingViewShouldAppear: Bool = true
    
    // MARK: - Main View
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("home".localized(), systemImage: "house")
                        .accessibilityLabel("home.page.tab".localized())
                }
            FridgeView()
                .tabItem {
                    Label("my.fridge".localized(), systemImage: "snowflake")
                        .accessibilityLabel("myfridge.page.tab".localized())
                }
            FavoritesView()
                .tabItem {
                    Label("my.favorites".localized(), systemImage: "heart.fill")
                        .accessibilityLabel("myfavorites.page.tab".localized())
                }
        }
        .fullScreenCover(isPresented: $OnBoardingViewShouldAppear) {
            OnBoardingView(shouldAppear: $OnBoardingViewShouldAppear)
        }
    }
}


// MARK: - Previews
struct TabView_Previews: PreviewProvider {
    @StateObject static var favoritesViewModel = FavoritesViewModel()
    static var previews: some View {
        MyTabView()
            .environmentObject(favoritesViewModel)
    }
}
