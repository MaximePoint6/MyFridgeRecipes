//
//  SimpleTopBar.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 16/02/2023.
//

import SwiftUI

struct TopBarView: View {
    
    @StateObject var viewModel = TopBarViewModel()
    
    // MARK: - Main View
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.helloLabel)
                    .font(.caption)
                    .foregroundColor(.accentColor)
                Text("what.to.cook.today".localized())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.top, 5)
        .padding(.bottom, 5)
        .onAppear {
            viewModel.updateHelloLabel()
        }
    }
}


// MARK: - Previews
struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
            .previewLayout(.sizeThatFits)
    }
}

