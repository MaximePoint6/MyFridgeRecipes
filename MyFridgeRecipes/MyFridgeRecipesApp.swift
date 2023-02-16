//
//  MyFridgeRecipesApp.swift
//  My fridge recipes
//
//  Created by Maxime Point on 20/01/2023.
//

import SwiftUI

@main
struct MyFridgeRecipesApp: App {
    
    @StateObject var topBarViewModel = TopBarViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()

    var body: some Scene {
        WindowGroup {
            MyTabView()
                .environmentObject(topBarViewModel)
                .environmentObject(favoritesViewModel)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
