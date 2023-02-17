//
//  SimpleTopBar.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 16/02/2023.
//

import SwiftUI

struct SimpleTopBar: View {
    
    @State private var showSettingsView = false
    var viewModel: TopBarViewModel
    
    // MARK: - Main View
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.helloLabel)
                    .font(.caption)
                    .foregroundColor(.accentColor)
                titleSection
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.top, 5)
        .padding(.bottom, 5)
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
    }
    
    // MARK: - SUbviews
    var titleSection: some View {
        VStack(alignment: .leading) {
            Text("what.to.cook.today".localized())
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
    }
}


// MARK: - Preview
struct SimpleTopBar_Previews: PreviewProvider {
    @StateObject static var topBarViewModel = TopBarViewModel()
    static var previews: some View {
        SimpleTopBar(viewModel: topBarViewModel)
            .previewLayout(.sizeThatFits)
    }
}

