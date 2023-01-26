//
//  MyFridgeRecipesApp.swift
//  My fridge recipes
//
//  Created by Maxime Point on 20/01/2023.
//

import SwiftUI

@main
struct MyFridgeRecipesApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var homeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            MyTabView()
                .environmentObject(homeViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
