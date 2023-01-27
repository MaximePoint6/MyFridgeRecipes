//
//  SearchBarView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var keyBoardType: UIKeyboardType
    var placeHolderText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    text.isEmpty ? Color.gray : Color.black
                )
            TextField(placeHolderText, text: $text)
                .keyboardType(keyBoardType)
                .foregroundColor(Color.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.black)
                        .opacity(text.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            text = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray6))
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}


// MARK: - Preview
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""), keyBoardType: .asciiCapable, placeHolderText: "Search a recipe")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}
