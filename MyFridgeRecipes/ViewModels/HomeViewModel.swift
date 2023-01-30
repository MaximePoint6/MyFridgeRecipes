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
    @Published var nextRecipesLoading = false
    
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
        fetchRandomRecipes()
    }
    
    func fetchRandomRecipes() {
        apiManager.getRequest(router: Router.fetchRandomRecipes) { (result: Result<Recipes, AFError>) in
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? ""
                    self.recipes = response.hits ?? []
                    self.pageState = .loaded(self.recipes)
                case .failure(let error):
                    self.ErroManager(error: error)
            }
        }
    }
    
    func fetchNextRecipesWithUrl() {
        if self.nextRecipesUrl.isEmpty {
            return
        }
        self.nextRecipesLoading = true
        apiManager.getRequest(router: Router.fetchNextRecipesWithUrl(self.nextRecipesUrl)) { (result: Result<Recipes, AFError>) in
            self.nextRecipesLoading = false
            switch result {
                case .success(let response):
                    self.nextRecipesUrl = response._links?.next?.href ?? ""
                    self.recipes.append(contentsOf: response.hits ?? [])
                    self.pageState = .loaded(self.recipes)
                case .failure(let error):
                    self.ErroManager(error: error)
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
