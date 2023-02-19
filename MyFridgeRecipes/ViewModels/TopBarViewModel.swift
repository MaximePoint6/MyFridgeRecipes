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
        startTimer()
    }
    
    // MARK: - Privates functions
    /// Update helloLabel
    private func updateHelloLabel() {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour > 5 && hour <= 12 {
            helloLabel = "good.morning,".localized()
        } else if hour > 12 && hour <= 18 {
            helloLabel = "good.afternoon,".localized()
        } else {
            helloLabel = "good.evening,".localized()
        }
    }
    
    /// Create a Timer that executes the updateHelloLabel method every hour
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
            self.updateHelloLabel()
        }
    }
    
}

