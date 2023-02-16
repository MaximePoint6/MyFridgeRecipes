//
//  SearchBarView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    var keyBoardType: UIKeyboardType
    var placeHolderText: String
    
    // MARK: - Main View
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
                .accessibility(hidden: true)
            TextField(placeHolderText, text: $text)
            .keyboardType(keyBoardType)
            .accessibilityValue(text.isEmpty ? Text("empty.search.bar".localized()) : Text("text.in.search.bar".localized() + text))
            .accessibilityLabel("search.bar".localized())
            .accessibilityAddTraits(.isSearchField)
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color.gray)
                .opacity(text.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    text = ""
                }
                .accessibility(hidden: text.isEmpty ? true: false)
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel("delete".localized())
                .accessibility(hint: Text("delete.text".localized()))
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? Color(.systemGray5): Color(.systemGray6))
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding(.leading)
        .padding(.trailing)
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
}


// MARK: - Preview
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant("test"), keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
            .previewLayout(.sizeThatFits)
        SearchBarView(text: .constant(""), keyBoardType: .asciiCapable, placeHolderText: "search.recipe".localized())
            .previewLayout(.sizeThatFits)
    }
}
