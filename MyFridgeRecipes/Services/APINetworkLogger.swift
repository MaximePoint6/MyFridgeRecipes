//
//  APINetworkLogger.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

// To put logs in console
class APINetworkLogger: EventMonitor {
  let queue = DispatchQueue(label: "com.maximepoint.myfridgerecipes.networklogger")

  func requestDidFinish(_ request: Request) {
    print(request.description)
  }

  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard let data = response.data else {
      return
    }
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      print(json)
    }
  }
}