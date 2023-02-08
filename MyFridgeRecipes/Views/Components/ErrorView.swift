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
            Text("something.went.wrong".localized())
                .font(.title)
                .padding()
            Group {
                switch error {
                case .decoding:
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
            ErrorView(error: .backend(400))
                .previewLayout(.sizeThatFits)
        }
    }
}
