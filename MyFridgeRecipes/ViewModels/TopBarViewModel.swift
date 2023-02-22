//
//  TopBarViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import Foundation

class TopBarViewModel: ObservableObject {
    
    /// Welcome / greeting message depending on the time.
    @Published var helloLabel: String = ""
    
    init() {
        updateHelloLabel()
    }
    
    // MARK: - Functions
    /// Update helloLabel
    func updateHelloLabel(hour: Int = Calendar.current.component(.hour, from: Date())) {
        if hour > 5 && hour <= 12 {
            helloLabel = "good.morning,".localized()
        } else if hour > 12 && hour <= 18 {
            helloLabel = "good.afternoon,".localized()
        } else {
            helloLabel = "good.evening,".localized()
        }
    }
    
}

