//
//  ApiManager.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire
import SwiftUI

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    init (sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    // Custom Session
    private var sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        // Code caching the data, and if there is no network, we recover the cache.
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        
        // To put logs in console
        let networkLogger = NetworkLogger()
        // Retry a request that had an error (settings: max retry, delay, etc.)
        let interceptor = MyRequestInterceptor()
        
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
    }()
    
    
    // MARK: - Function performing network requests
    func getRequest<T: Codable>(router: URLRequestConvertible, completion: @escaping (Result<T, AFError>) -> Void) {
        sessionManager.request(router)
            .responseDecodable(of: T.self, decoder: SnakeCaseJSONDecoder()) { response in
                switch response.result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                }
            }
    }

}
