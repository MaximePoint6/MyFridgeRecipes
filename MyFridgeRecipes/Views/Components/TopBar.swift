//
//  TopBar.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct TopBar: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.helloLabel)
                Text("Maxime")
            }
            Spacer()
            Image(systemName: "person.circle")
                .font(.system(size: 40))
        }.padding(20)
    }
}


// MARK: - Preview
struct TopBar_Previews: PreviewProvider {
    
    @StateObject static var homeViewModel = HomeViewModel()
    
    static var previews: some View {
        TopBar()
            .environmentObject(homeViewModel)
    }
}
