//
//  ButtonView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import SwiftUI

struct ButtonView: View {
    
    let buttonType: ButtonType
    let color: Color
    let title: String
    let action: () -> Void
    
    enum ButtonType {
        case primary
        case secondary
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(title)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(buttonType == .primary ? .white : color)
                Spacer()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(buttonType == .primary ? .clear : color, lineWidth: 2)
            )
        })
        .background(
            RoundedRectangle(
                cornerRadius: 15,
                style: .continuous
            )
            .fill(buttonType == .primary ? color : .clear)
        )
        .padding(.leading)
        .padding(.trailing)
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonType: .primary, color: .accentColor, title: "Test Button", action: {})
            .previewLayout(.sizeThatFits)
        ButtonView(buttonType: .secondary, color: .accentColor, title: "Test Button", action: {})
            .previewLayout(.sizeThatFits)
    }
}
