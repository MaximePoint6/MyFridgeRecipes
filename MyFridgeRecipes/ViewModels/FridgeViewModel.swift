//
//  FridgeViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import Foundation
import Alamofire

class FridgeViewModel: ObservableObject {
    
    @Published private(set) var pageState = PageState.loading
    @Published var nextRecipesLoading = false
    @Published var foods = []
    
    enum PageState {
        case loading
        case failed(ErrorType)
        case loaded([Recipes.Hit])
    }
    
    private(set) var recipes: [Recipes.Hit] = []
    private var nextRecipesUrl = ""
    
    var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchFoodSearch(searchText: String) {
        apiManager.getRequest(router: Router.fetchFoodSearch(searchText)) { (result: Result<[String], AFError>) in
            switch result {
                case .success(let response):
                    self.foods = response
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
    
    func fetchRecipeSearch(searchText: String) {
        apiManager.getRequest(router: Router.fetchRecipeSearch(searchText)) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? ""
                    self.recipes = response.hits ?? []
                    self.pageState = .loaded(self.recipes)
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
    
    
    private func ErroManager(error: AFError) {
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
