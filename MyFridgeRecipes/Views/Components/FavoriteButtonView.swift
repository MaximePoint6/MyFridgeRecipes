//
//  FavoriteButtonView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 05/02/2023.
//

import SwiftUI

struct FavoriteButtonView: View {

    @Binding var isLiked: Bool
    let action: () -> Void
    let onColor: Color
    let offColor: Color
    
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .font(Font.system(.title2))
                .foregroundColor(isLiked ? onColor : offColor)
        })
    }
}

struct FavoriteButtonView_Previews: PreviewProvider {
    
    @State static var isLiked: Bool = true
    @State static var isNotLiked: Bool = false
    
    static var previews: some View {
        Group {
            FavoriteButtonView(isLiked: $isLiked, action: {}, onColor: Color.red, offColor: Color.gray)
                .previewLayout(.sizeThatFits)
            FavoriteButtonView(isLiked: $isNotLiked, action: {}, onColor: Color.red, offColor: Color.gray)
                .previewLayout(.sizeThatFits)
        }
    }
}
