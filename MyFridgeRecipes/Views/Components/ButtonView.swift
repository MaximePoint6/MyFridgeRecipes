//
//  ButtonView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import SwiftUI

struct ButtonView: View {
    
    let color: Color
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(title)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
        })
        .background(color)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(color: .black, title: "Test Button", action: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
