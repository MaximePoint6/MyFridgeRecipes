//
//  TopBarView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct TopBarView: View {
    
    @State private var showSettingsView = false
    var viewModel: TopBarViewModel
    
    // MARK: - Main View
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.helloLabel)
                    .font(.caption)
                Text("Maxime")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            Image(systemName: "person.circle")
                .font(.system(size: 50))
                .onTapGesture {
                    showSettingsView.toggle()
                }
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.top, 5)
        .padding(.bottom, 5)
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
    }
}


// MARK: - Preview
struct TopBar_Previews: PreviewProvider {
    @StateObject static var topBarViewModel = TopBarViewModel()
    static var previews: some View {
        TopBarView(viewModel: topBarViewModel)
            .previewLayout(.sizeThatFits)
    }
}
