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
            IngredientSearchView(fridgeViewModel: viewModel)
        }
    }
    
    // MARK: - Subviews
    private var ingredientListSection: some View {
        ZStack(alignment: .bottom) {
            List {
                Section {
                    ForEach(viewModel.fridgeIngredientList, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: withAnimation { viewModel.deleteIngredient })
                } header: {
                    Text(viewModel.selectedIngredients)
                }
            }.listStyle(.insetGrouped)
            helpSection
        }
    }
    
    @ViewBuilder
    private var helpSection: some View {
        if viewModel.fridgeIngredientList.isEmpty {
            HStack(alignment: .bottom, spacing: 20) {
                Image(systemName: "arrow.turn.left.down")
                    .font(.largeTitle)
                    .rotationEffect(.degrees(10))
                    .blinking(duration: 0.5)
                    .accessibility(hidden: true)
                Image("Fridge")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipped()
                    .accessibility(hidden: true)
                Text("add.fridge.ingredients".localized())
                    .font(.title2)
            }
            .foregroundColor(.accentColor)
            .padding()
        }
    }
    
    @ViewBuilder
    private var buttonsSection: some View {
        ButtonView(buttonType: .secondary, color: .accentColor, title: "add.other.ingredient".localized()) {
            showSearchModalView.toggle()
        }
        .accessibilityHint("navigate.to.ingredient.search.View".localized())
        Spacer()
        ButtonView(buttonType: .primary, color: .accentColor, title: "show.recipes".localized()) {
            viewModel.fetchRecipeSearch()
            self.action = 1
        }
        .accessibilityHint("navigate.to.recipe.list".localized())
        // Navigation Link when the second button is clicked.
        NavigationLink(destination: RecipesListView(pageState: $viewModel.pageState, loadNextRecipes: viewModel.fetchNextRecipesWithUrl, nextRecipesLoading: viewModel.nextRecipesLoading, sectionTitle: "recipe.ideas".localized()), tag: 1, selection: $action) { EmptyView() }
            .accessibility(hidden: true)
    }
    
}


// MARK: - Previews
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
