//
//  ErrorView.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let error: ErrorManager.ErrorType
    
    // MARK: - Main View
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("something.went.wrong".localized())
                .font(.title)
            Group {
                switch error {
                    case .decoding, .otherProblem:
                        Text("contact.developer".localized())
                    case .noInternet:
                        Text("no.internet.connection".localized())
                    case .backend(let code):
                        switch code {
                            case 403:
                                Text("api.limit".localized())
                            case 503:
                                Text("service.unavailable".localized())
                            default:
                                Text("server.error".localized() + String(code))
                        }
                }
            }
        }
        .padding()
    }
}


// MARK: - Previews
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(error: .noInternet)
                .previewLayout(.sizeThatFits)
            ErrorView(error: .backend(503))
                .previewLayout(.sizeThatFits)
            ErrorView(error: .decoding)
                .previewLayout(.sizeThatFits)
            ErrorView(error: .backend(400))
                .previewLayout(.sizeThatFits)
        }
    }
}
