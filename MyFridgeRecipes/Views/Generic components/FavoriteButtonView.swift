//
//  FavoriteButtonView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 05/02/2023.
//

import SwiftUI

struct FavoriteButtonView: View {
    
    @Binding var isLiked: Bool
    let onColor: Color
    let offColor: Color
    let action: () -> Void
    
    // Animation
    @State private var animate = false
    let animationDuration: Double = 0.1
    var animationScale: CGFloat {
        isLiked ? 0.5 : 1.5
    }
    
    // MARK: - Main View
    var body: some View {
        Button(action: {
            self.animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration, execute: {
                self.animate = false
                action()
            })
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .font(Font.system(.title2))
                .foregroundColor(isLiked ? onColor : offColor)
        })
        .scaleEffect(animate ? animationScale : 1)
        .animation(.easeIn(duration: animationDuration), value: isLiked)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("like".localized())
        .accessibilityHint(isLiked ? Text("remove.from.favorites".localized()) : Text("save.your.recipe".localized()))
        .accessibilityValue(isLiked ? Text("saved.recipe".localized()) : Text("recipe.not.saved".localized()))
    }
}


// MARK: - Previews
struct FavoriteButtonView_Previews: PreviewProvider {
    @State static var isLiked: Bool = true
    @State static var isNotLiked: Bool = false
    static var previews: some View {
        Group {
            FavoriteButtonView(isLiked: $isLiked, onColor: Color.red, offColor: Color.gray, action: {})
                .previewLayout(.sizeThatFits)
            FavoriteButtonView(isLiked: $isNotLiked, onColor: Color.red, offColor: Color.gray, action: {})
                .previewLayout(.sizeThatFits)
        }
    }
}
