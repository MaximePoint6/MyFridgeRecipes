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
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ForEach(viewModel.fridgeIngredientList, id: \.self) { item in
                            Text(item)
                        }
                        .onDelete(perform: withAnimation { viewModel.deleteItems })
                    } header: {
                        Text(viewModel.selectedIngredients)
                    }
                }.listStyle(.insetGrouped)
                ButtonView(color: .green, title: "add.other.food".localized()) {
                    showSearchModalView.toggle()
                }
                Spacer()
                NavigationLink(destination: RecipesListView(pageState: $viewModel.pageState, loadNextRecipes: viewModel.fetchNextRecipesWithUrl, nextRecipesLoading: viewModel.nextRecipesLoading),
                               tag: 1, selection: $action) {
                    EmptyView()
                }
                ButtonView(color: .black, title: "show.recipes".localized()) {
                    viewModel.fetchRecipeSearch()
                    self.action = 1
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showSearchModalView) {
            FoodSearchView(fridgeViewModel: viewModel)
        }
    }
    
}


// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        FridgeView()
    }
}
