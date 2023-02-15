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
    
    // MARK: - Main View
    var body: some View {
        NavigationView {
            VStack {
                ingredientListSection
                buttonsSection
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .accessibilityHint("remove.fridge.ingredients".localized())
                }
            }
        }
        .sheet(isPresented: $showSearchModalView) {
            FoodSearchView(fridgeViewModel: viewModel)
        }
    }
    
    // MARK: - Subviews
    var ingredientListSection: some View {
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
    }
    
    @ViewBuilder
    var buttonsSection: some View {
        ButtonView(buttonType: .secondary, color: .accentColor, title: "add.other.food".localized()) {
            showSearchModalView.toggle()
        }
        Spacer()
        NavigationLink(destination: RecipesListView(pageState: $viewModel.pageState, loadNextRecipes: viewModel.fetchNextRecipesWithUrl, nextRecipesLoading: viewModel.nextRecipesLoading, sectionTitle: "recipe.ideas".localized()),
                       tag: 1, selection: $action) {
            EmptyView()
        }
        ButtonView(buttonType: .primary, color: .accentColor, title: "show.recipes".localized()) {
            viewModel.fetchRecipeSearch()
            self.action = 1
        }
    }
    
}


// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
