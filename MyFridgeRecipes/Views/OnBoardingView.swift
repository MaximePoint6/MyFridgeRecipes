//
//  OnBoardingView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 17/02/2023.
//

import SwiftUI

struct OnBoardingView: View {
    @Binding var shoulShowOnBoarding: Bool
    
    var body: some View {
        Color.accentColor
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
                VStack {
                    VStack(spacing: 5) {
                        Text("welcome".localized())
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                        Text("get.ready".localized())
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                    }
                    ZStack(alignment: .bottom) {
                        Image("OnBoardingImage")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .accentColor.opacity(1)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    }
                    .accessibility(hidden: true)
                    OnBoardingButtonView(backgroundColor: .white, textColor: .accentColor, title: "show.recipes".localized(), action: {
                        shoulShowOnBoarding.toggle()
                    })
                }
                .padding()
            )
    }
}


struct OnBoardingView_Previews: PreviewProvider {
    @State static var shoulShowOnBoarding = true
    
    static var previews: some View {
        OnBoardingView(shoulShowOnBoarding: $shoulShowOnBoarding)
    }
}
