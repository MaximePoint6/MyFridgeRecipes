//
//  OnBoardingButtonView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 17/02/2023.
//

import SwiftUI

struct OnBoardingButtonView: View {
    
    let backgroundColor: Color
    let textColor: Color
    let title: String
    let action: () -> Void
    
    enum ButtonType {
        case primary
        case secondary
    }
    
    // MARK: - Main View
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(title)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(textColor)
                Spacer()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(backgroundColor, lineWidth: 2)
            )
        })
        .background(
            RoundedRectangle(
                cornerRadius: 15,
                style: .continuous
            )
            .fill(backgroundColor)
        )
        .padding(.leading, 50)
        .padding(.trailing, 50)
        .padding(.top, 5)
        .padding(.bottom, 5)
        .accessibilityLabel(title)
    }
}

// MARK: - Preview
struct OnBoardingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingButtonView(backgroundColor: .white, textColor: .accentColor, title: "Test Button", action: {})
            .previewLayout(.sizeThatFits)
        OnBoardingButtonView(backgroundColor: .accentColor, textColor: .white, title: "Test Button", action: {})
            .previewLayout(.sizeThatFits)
    }
}

