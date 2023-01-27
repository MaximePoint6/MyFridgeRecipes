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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.helloLabel)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("Maxime")
                    .font(.title)
                    .bold()
            }
            Spacer()
            Image(systemName: "person.circle")
                .font(.system(size: 50))
                .onTapGesture {
                    showSettingsView.toggle()
                }
        }
        .padding(20)
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
            .preferredColorScheme(.light)
    }
}
