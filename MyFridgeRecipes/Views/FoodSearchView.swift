//
//  FoodSearchView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 26/01/2023.
//

import SwiftUI

struct FoodSearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchText = ""
    private var listOfFood = ["test1", "test2", "test3"]
    
    // Filter countries
    var foods: [String] {
        let lcFoods = listOfFood.map { $0.lowercased() }
        return searchText == "" ? lcFoods : lcFoods.filter { $0.contains(searchText.lowercased()) }
    }
    
    var body: some View {
        VStack {
            SearchBarView(text: $searchText, keyBoardType: .asciiCapable, placeHolderText: "Search food")
            List {
                ForEach(foods, id: \.self) { country in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(country.capitalized)
                    }
                    .padding()
                }
            }
 
        }
    }
}


// MARK: - Preview
struct FoodSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSearchView()
    }
}
