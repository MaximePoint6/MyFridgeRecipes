//
//  FoodSearchViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 02/02/2023.
//

import Foundation
import Alamofire

class FoodSearchViewModel: ObservableObject {
    
//    @Published private(set) var pageState = PageState.loading
    @Published var foods = []
    
    var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
//    private var foods: [String] = [] {
//        didSet {
//            self.pageState = .loaded(foods)
//        }
//    }
    
    func fetchFoodSearch(searchText: String) {
        apiManager.getRequest(router: Router.fetchFoodSearch(searchText)) { (result: Result<[String], AFError>) in
            switch result {
                case .success(let response):
                    self.foods = response
                case .failure:
//                    self.pageState = ErrorManager.getErrorPageState(error: error)
                    self.foods = []
            }
        }
    }
    
}
