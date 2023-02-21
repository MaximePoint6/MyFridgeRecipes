//
//  TopBarViewModelTests.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 20/02/2023.
//

import XCTest
import Alamofire
@testable import MyFridgeRecipes

final class TopBarViewModelTests: XCTestCase {
    
    var topBarViewModel: TopBarViewModel!
    
    override func setUp() {
        super.setUp()
        topBarViewModel = TopBarViewModel()
    }
    
    override func tearDown() {
        topBarViewModel = nil
        super.tearDown()
    }
    
    // MARK: - fetchRecipeSearch Function
    func test_updateHelloLabel_morning() {
        let label = "good.morning,".localized()
        topBarViewModel.updateHelloLabel(hour: 8)
        XCTAssertEqual(topBarViewModel.helloLabel, label)
    }
    
    func test_updateHelloLabel_afternoon() {
        let label = "good.afternoon,".localized()
        topBarViewModel.updateHelloLabel(hour: 15)
        XCTAssertEqual(topBarViewModel.helloLabel, label)
    }
    
    func test_updateHelloLabel_evening() {
        let label = "good.evening,".localized()
        topBarViewModel.updateHelloLabel(hour: 22)
        XCTAssertEqual(topBarViewModel.helloLabel, label)
    }
    
}
