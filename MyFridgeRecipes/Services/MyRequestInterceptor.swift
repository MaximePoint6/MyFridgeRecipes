//
//  MyRequestInterceptor.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

class MyRequestInterceptor: RequestInterceptor {
  let retryLimit = 3 // si appel ne fonctionn pas, alors 3 essais max (uniquement si statutCode est entre 500 et 599)
  let retryDelay: TimeInterval = 10 // 10secondes max par appel

    // pour mettre des entetes aux requetes comme Authorization par exemple
  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//    var urlRequest = urlRequest
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

