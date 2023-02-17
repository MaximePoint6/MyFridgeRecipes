//
//  IconAndDataView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 10/02/2023.
//

import SwiftUI

struct IconAndDataView: View {
    
    let icon: String
    let data: String
    let subtitle: String
    
    // MARK: - Main View
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 2)
                .accessibility(hidden: true)
            Text(data)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text(subtitle)
                .font(.footnote)
                .foregroundColor(.white)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(subtitle + data)
    }
}

// MARK: - Preview
struct IconAndDataView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.accentColor)
            IconAndDataView(icon: "flame", data: "555 kcals", subtitle: "per.portion".localized())
        }
        .previewLayout(.sizeThatFits)
    }
}
