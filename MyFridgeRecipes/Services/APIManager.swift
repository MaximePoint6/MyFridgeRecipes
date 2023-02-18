//
//  APIManager.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire
import SwiftUI

class APIManager: APIManagerProtocol {
    static let shared = APIManager()
    private init() {}
    
    init (sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    /// Creates an Alamofire session that creates and manages Alamofire's `Request` with several features.
    /// (queuing, interception, trust management, redirect handling, and response cache handling).
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
        
        /// Add alamofire network logs / events.
        let networkLogger = APINetworkLogger()
        /// Add feature to etry a request that had an error (settings: max retry, delay, etc.).
        let interceptor = APIRequestInterceptor()
        
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
    }()
    
    
    // MARK: - Function performing network requests

    /// Launches a request with Alamofire from sessionManager, according to the router entered.
    /// - Parameters:
    ///   - router: Provide the desired router to launch the request (allows to add to the request, the url, the parameters, the method ...).
    ///   - completion: Returns a completion with a result of type T for success and AFError for failure.
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
