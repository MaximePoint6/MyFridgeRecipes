//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    
    @Published private(set) var pageState = PageState.loading
    
    enum PageState {
        case loading
        case failed(ErrorType)
        case loaded([Recipes.Hit])
    }
    
    var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
        fetchRecipeSearch()
    }
    
    var helloLabel: String {
        // welcome / greeting message
        let hour = Calendar.current.component(.hour, from: Date())
        if hour > 5 && hour <= 12 {
            return "good.morning,".localized()
        } else if hour > 12 && hour <= 18 {
            return "good.afternoon,".localized()
        } else {
            return "good.evening,".localized()
        }
    }
    
    func fetchFoodSearch() {
        APIManager.shared.fetchFoodSearch(query: "tom") { foods in
            print(foods)
        }
    }
    
    func fetchRecipeSearch() {
        apiManager.fetchRecipeSearch(query: "potatoes chicken") { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.pageState = .loaded(response.hits ?? [])
                case .failure(let error):
                    if let code = error.responseCode {
                        self.pageState = .failed(.backend(code))
                    }
                    if error.isSessionTaskError {
                        self.pageState = .failed(.noInternet)
                    }
                    if error.isResponseSerializationError {
                        self.pageState = .failed(.decoding)
                    }
                    print(error)
            }
        }
    }
    
}
