//
//  Persistence.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import CoreData
import UIKit

struct PersistenceController {
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.managedContext
        for _ in 0..<10 {
            /*let newItem = Item(context: viewContext)
            newItem.timestamp = Date()*/
        }
        result.saveContext()
        return result
    }()
    
    var managedContext: NSManagedObjectContext {
        container.viewContext
    }

    private let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Recipes_iOS")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        saveAutomatically()
    }
    
    private func saveAutomatically() {
        let center = NotificationCenter.default
        let notification = UIApplication.willResignActiveNotification

        center.addObserver(forName: notification, object: nil, queue: nil) { _ in
            self.saveContext()
        }
    }

    // MARK: - Core Data Saving support

    func saveContext() {
        guard managedContext.hasChanges else {
            return
        }

        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

}
