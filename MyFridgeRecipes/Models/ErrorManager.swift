//
//  ErrorType.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 23/01/2023.
//

import Foundation
import Alamofire

class ErrorManager {
    
    enum ErrorType: Equatable {
        case decoding
        case noInternet
        case backend(Int)
        case otherProblem
    }
    
    /// To deduce the PageState based on the alamofire error.
    /// - Parameter error: a Alamofire Error.
    /// - Returns: Page State.
    static func getErrorPageState(error: AFError) -> PageState {
        if let code = error.responseCode {
            return .failed(.backend(code))
        }
        if error.isSessionTaskError {
            return .failed(.noInternet)
        }
        if error.isResponseSerializationError {
            return .failed(.decoding)
        }
        print(error)
        return .failed(.otherProblem)
    }
    
}
