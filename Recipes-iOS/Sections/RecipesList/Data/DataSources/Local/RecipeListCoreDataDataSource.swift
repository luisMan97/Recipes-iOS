//
//  RecipeListCoreDataDataSource.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Combine
import CoreData

class RecipeListCoreDataDataSource: NSObject, LocalRecipesListDataSource {
    
    // MARK: - Internal Properties

    var recipes = CurrentValueSubject<[RecipeCoreData], Never>([])

    // MARK: - Private Properties

    private var viewContext = PersistenceController.shared.managedContext
    private var fetchRequest: NSFetchRequest<RecipeCoreData> = {
        let fetchRequest: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return fetchRequest
    }()
    private lazy var recipeFetchController: NSFetchedResultsController<RecipeCoreData> = {
        let recipeFetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                             managedObjectContext: viewContext,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        return recipeFetchController
    }()

    // MARK: - Initializers

    override init() {
        super.init()
        recipeFetchController.delegate = self
        getFavoriteRecipes()
    }

    // MARK: - Internal Methods
    
    func deleteFavoriteRecipes(favoriteRecipes: [RecipeCoreData], offsets: IndexSet) {
        offsets.map { favoriteRecipes[$0] }.forEach(viewContext.delete)
        saveContext()
    }

    func deleteAllRecipes() {
        let fetchRequest: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()

        do {
            let recipes = try viewContext.fetch(fetchRequest)

            recipes.forEach(viewContext.delete)
            try viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }


    // MARK: - Private Methods

    private func getFavoriteRecipes() {
        do {
            try recipeFetchController.performFetch()
            recipes.value = recipeFetchController.fetchedObjects ?? []
        } catch {
            NSLog(error.localizedDescription)
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

// MARK: - NSFetchedResultsControllerDelegate
extension RecipeListCoreDataDataSource: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let recipes = controller.fetchedObjects as? [RecipeCoreData] else {
            return
        }
        self.recipes.value = recipes
    }
}
