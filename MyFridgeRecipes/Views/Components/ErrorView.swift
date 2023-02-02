//
//  ErrorView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let error: ErrorManager.ErrorType
    
    var body: some View {
        VStack {
            Text("Something went wrong")
                .font(.title)
                .padding()
            Group {
                switch error {
                case .decoding:
                    Text("Please contact developer")
                case .noInternet:
                    Text("Please check your internet connection")
                case .backend(let code):
                    switch code {
                    case 403:
                        Text("API limit reached, wait a second")
                    case 503:
                        Text("Service unavailable")
                    default:
                        Text("Server error code: \(code)")
                    }
                }
            }
        }
        .padding()
    }
}


// MARK: - Preview
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(error: .noInternet)
                .previewLayout(.sizeThatFits)
            ErrorView(error: .backend(503))
                .previewLayout(.sizeThatFits)
            ErrorView(error: .decoding)
                .previewLayout(.sizeThatFits)
        }
    }
}
