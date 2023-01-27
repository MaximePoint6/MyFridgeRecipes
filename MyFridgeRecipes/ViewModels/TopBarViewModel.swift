//
//  TopBarViewModel.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 27/01/2023.
//

import Foundation

class TopBarViewModel: ObservableObject {
    
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
    
}

