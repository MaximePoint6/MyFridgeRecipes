//
//  MockCDManager.swift
//  MyFridgeRecipesTests
//
//  Created by Maxime Point on 20/02/2023.
//

import Foundation
import CoreData
@testable import MyFridgeRecipes

final class MockCDManager: CDManagerProtocol {
    
    // MARK: - Properties
    
    /// ViewContext of Coredata.
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Privates Properties
    
    /// Name of the database to instantiate (i.e. name of the .xcdatamodel file).
    private let persistentContainerName = "MyFridgeRecipes"
    
    /// LazyVar to load the property only the first time. This prevents installing CoreData multiple times = performance gain.
    private lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: persistentContainerName)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}

