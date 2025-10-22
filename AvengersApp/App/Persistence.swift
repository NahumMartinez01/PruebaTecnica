//
//  Persistence.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    private init() {}
    
    lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AvengersApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error cargando Core Data: \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
               print("Error saving context \(error)")
            }
        }
    }
}
