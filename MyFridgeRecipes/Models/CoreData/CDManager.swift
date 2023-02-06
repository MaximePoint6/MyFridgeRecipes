//
//  CDManager.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 06/02/2023.
//

import Foundation
import CoreData

final class CDManager {
    
    // MARK: - Singleton
    static let shared = CDManager()
    private init() {}
    
    // MARK: - Properties
    
    var viewContext: NSManagedObjectContext {
        return CDManager.shared.persistentContainer.viewContext
    }
    
    private let persistentContainerName = "MyFridgeRecipes" // nom de la base qu'on souhaite instancier (c.a.d nom du fichier .xcdatamodel)
    
    // Lazy var, car on souhaite charger cette propriété seulement lorsqu'elle est réclamée pour la première fois.
    // Ça évite d'installer plusieurs fois Core Data = gain de performance.
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)") // code à modifier, pour traiter convenablement ce genre d'erreur
            }
        })
        return container
    }()
    
}
