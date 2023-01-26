//
//  HomeView.swift
//  My fridge recipes
//
//  Created by Maxime Point on 20/01/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @EnvironmentObject var viewModel: HomeViewModel
    @State var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TopBar()
                switch viewModel.pageState {
                    case .loading:
                        ProgressView()
                    case .failed(let error):
                        ErrorView(error: error)
                    case .loaded(let recipes):
                        Text("Idées de recette")
                        SearchBarView(text: $searchText)
                        List {
                            ForEach(recipes) { item in
                                NavigationLink {
                                    Text("Item at \(item.recipe?.label ?? "no label")")
                                } label: {
                                    Text(item.recipe?.label ?? "no label")
                                }
                            }
                        }
                }
                Button("Request") {
                    HomeViewModel().fetchRecipeSearch()
                }
            }
            Text("Select an item")
        }
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    @StateObject static var viewModel = HomeViewModel()
    
    static var previews: some View {
        HomeView()
            .environmentObject(viewModel)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
