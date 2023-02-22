//
//  APIRequestInterceptor.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

/// To Add feature to etry a request that had an error (settings: max retry, delay, etc.).
class APIRequestInterceptor: RequestInterceptor {

 /// Number of times the `Request` can be retried. (only if statusCode is between 500 and 599).
  let retryLimit = 3

    /// Maximum delay per request (in seconds).
  let retryDelay: TimeInterval = 10

  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    var urlRequest = urlRequest
      // To put headers to requests (example: Authorization)
      urlRequest.setValue("\(Language.en.rawValue)", forHTTPHeaderField: "Accept-Language")
      urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
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

