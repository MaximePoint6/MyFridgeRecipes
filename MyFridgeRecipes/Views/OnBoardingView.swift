//
//  OnBoardingView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 17/02/2023.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Binding var shouldAppear: Bool
    
    // MARK: - Main View
    var body: some View {
            VStack {
                titleSection
                imageSection
                OnBoardingButtonView(backgroundColor: .white, textColor: .accentColor, title: "show.recipes".localized(), action: { shouldAppear.toggle() })
                    .accessibilityHint(Text("navigates.main.screen".localized()))
            }
            .padding()
            .background(Color.accentColor.ignoresSafeArea())
    }
    
    // MARK: - Subviews
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(String(format: "welcome".localized(), Bundle.main.displayName ?? "MyFridgeRecipe"))
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(.white)
            Text("get.ready".localized())
                .font(.largeTitle)
                .fontWeight(.black)
                .textCase(.uppercase)
                .foregroundColor(.white)
        }
    }
    
    private var imageSection: some View {
        ZStack(alignment: .bottom) {
            Image.onBoardingImage
                .resizable()
                .scaledToFit()
                .clipped()
            LinearGradient(
                gradient: Gradient(colors: [.clear, .accentColor.opacity(1)]),
                startPoint: .center,
                endPoint: .bottom
            )
        }
        .accessibility(hidden: true)
    }
    
}


// MARK: - Previews
struct OnBoardingView_Previews: PreviewProvider {
    @State static var OnBoardingViewShouldAppear = true
    static var previews: some View {
        OnBoardingView(shouldAppear: $OnBoardingViewShouldAppear)
    }
}
