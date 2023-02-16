//
//  FoodSearchView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import SwiftUI

struct FoodSearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var fridgeViewModel: FridgeViewModel
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var timer: Timer?
    private let delay: TimeInterval = 0.7 // delay in seconds
    
    // MARK: - Main View
    var body: some View {
        VStack {
            SearchBarView(text: $searchText, isEditing: $isEditing, keyBoardType: .asciiCapable, placeHolderText: "search.ingredient".localized())
                .padding(.top)
                .padding(.bottom)
            ingredientList
            
        } // To avoid making network calls at each change in the textField, we add a delay before launching the request.
        .onChange(of: searchText) { newValue in
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: self.delay, repeats: false, block: { _ in
                if !searchText.isEmpty {
                    fridgeViewModel.fetchFoodSearch(searchText: newValue)
                }
            })
        }
    }
    
    // MARK: - Subviews
    var ingredientList: some View {
        List {
            ForEach(fridgeViewModel.ingredients, id: \.self) { ingredient in
                Button {
                    fridgeViewModel.addIngredient(ingredient)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(ingredient.capitalized)
                }
                .padding()
            }
        }
    }
}


// MARK: - Preview
struct FoodSearchView_Previews: PreviewProvider {
    @StateObject static var fridgeViewModel = FridgeViewModel()
    static var previews: some View {
        FoodSearchView(fridgeViewModel: fridgeViewModel)
    }
}
