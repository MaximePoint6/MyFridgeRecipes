//
//  APIRequestInterceptor.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

// Retry a request that had an error (settings: max retry, delay, etc.)
class APIRequestInterceptor: RequestInterceptor {
  let retryLimit = 3 // If the request doesn't work, then 3 tries max (only if statusCode is between 500 and 599)
  let retryDelay: TimeInterval = 10 // maximum delay per request (in seconds)

    // To put headers to requests (example: Authorization)
  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    var urlRequest = urlRequest
      urlRequest.setValue("\(Language.en.rawValue)", forHTTPHeaderField: "Accept-Language")
      urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
//    if let token = TokenManager.shared.fetchAccessToken() {
//      urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
//    }
    completion(.success(urlRequest))
  }

  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    let response = request.task?.response as? HTTPURLResponse
    // Retry for 5xx status codes
    if let statusCode = response?.statusCode, (500...599).contains(statusCode), request.retryCount < retryLimit {
        completion(.retryWithDelay(retryDelay))
    } else {
      return completion(.doNotRetry)
    }
  }
}

