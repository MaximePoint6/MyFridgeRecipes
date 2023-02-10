//
//  APIManagerProtocol.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 09/02/2023.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func getRequest<T: Codable>(router: URLRequestConvertible, completion: @escaping (Result<T, AFError>) -> Void)
}
