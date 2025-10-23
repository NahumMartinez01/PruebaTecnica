//
//  Persistence.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    
    static let preview = PersistenceController(inMemory: true)
    
    lazy var context = persistentContainer.viewContext
    
    private let inMemory: Bool
    
    private init(inMemory: Bool = false) {
        //MARK:  DETECTAMOS SI ESTAMOS UTILIZANDO TEST DE UI
        
        self.inMemory = inMemory || CommandLine.arguments.contains("-UITest")
    }
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AvengersApp")
        
       
        if inMemory {
            //MARK: UTILIZAMOS ALMACENAMIENTO EN MEMORIA PARA LOS TEST
            
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error cargando Core Data: \(error)")
            }
        }
        
        //Configuramos para que los cambios realizados los podamos ver reflejados inmediatamente en UITest
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                
                // Sincronización inmediata
                context.processPendingChanges()
            }
            catch {
               print("Error saving context \(error)")
            }
        }
    }
}
