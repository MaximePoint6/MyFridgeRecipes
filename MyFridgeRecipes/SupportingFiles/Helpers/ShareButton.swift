//
//  ShareSheet.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 15/02/2023.
//

import Foundation
import UIKit

/// Starts the share view.
/// - Parameter elements: elements to share.
func shareButton(elements: [Any]) {
    let activityController = UIActivityViewController(activityItems: elements, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityController,
                                                                        animated: true,
                                                                        completion: nil)
}
