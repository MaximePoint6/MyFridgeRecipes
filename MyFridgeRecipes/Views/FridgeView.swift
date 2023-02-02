//
//  FridgeView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct FridgeView: View {
    
    @StateObject var viewModel = FridgeViewModel()
    @State var showSearchModalView = false
    @State private var action: Int? = 0
    let foods = ["Tomate"]
    
    var foodsString: String {
        return foods.compactMap { $0 }.joined(separator: ", ")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ForEach(foods, id: \.self) { item in
                            Text(item)
                        }
                        .onDelete(perform: deleteItems)
                    } header: {
                        Text("\(foods.count) ingrédients selectionnés")
                    }
                }.listStyle(.insetGrouped)
                Button {
                    showSearchModalView.toggle()
                } label: {
                    Text("Add other food".localized())
                }.padding(20)
                Spacer()
                NavigationLink(destination: RecipesListView(pageState: viewModel.pageState, loadNextRecipes: viewModel.fetchNextRecipesWithUrl, nextRecipesLoading: viewModel.nextRecipesLoading),
                               tag: 1, selection: $action) {
                    EmptyView()
                }
                ButtonView(color: .black, title: "Show the recipes") {
                    viewModel.fetchRecipeSearch(searchText: foodsString)
                    self.action = 1
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showSearchModalView) {
            FoodSearchView()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //            offsets.map { items[$0] }.forEach(viewContext.delete)
        }
    }
    
}


// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        FridgeView()
    }
}
