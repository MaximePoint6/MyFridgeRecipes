//
//  FavouritesView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var topBarViewModel: TopBarViewModel
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        VStack {
            TopBarView(viewModel: topBarViewModel)
            Spacer()
            Text("Favorite View")
            Spacer()
        }
    }
}


// MARK: - Preview
struct FavoriteView_Previews: PreviewProvider {
    @StateObject static var topBarViewModel = TopBarViewModel()
    
    static var previews: some View {
        FavouritesView()
            .environmentObject(topBarViewModel)
    }
}
