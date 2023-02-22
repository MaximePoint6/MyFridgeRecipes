//
//  CDManager+Protocol.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 20/02/2023.
//

import Foundation
import Alamofire
import CoreData

protocol CDManagerProtocol {
    var viewContext: NSManagedObjectContext { get }
}

