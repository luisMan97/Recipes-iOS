//
//  RecipeDetailRepository.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Combine
import CoreData

protocol RecipeDetailRepositoryProtocol {
    var recipes: CurrentValueSubject<[RecipeCoreData], Never> { get }
    func saveRecipe(_ recipe: RecipeViewModel)
}

class RecipeDetailRepository: NSObject, RecipeDetailRepositoryProtocol {

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

    override init() {
        super.init()
        recipeFetchController.delegate = self
        getFavoriteRecipes()
    }

    // MARK: - Internal Methods

    func saveRecipe(_ recipe: RecipeViewModel) {
        let localRecipes = getRecipes().filter { $0.id == recipe.id }
        guard localRecipes.isEmpty else {
            deleteRecipe(recipe)
            return
        }
        let newItem = RecipeCoreData(context: viewContext)
        recipe.toCoreData(newItem)

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    // MARK: - Private Methods

    private func deleteRecipe(_ recipe: RecipeViewModel) {
        let fetchRequest: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()

        do {
            let recipes = try viewContext.fetch(fetchRequest)

            guard let recipeToDelete = recipes.first(where: { $0.id == recipe.id }) else {
                return
            }
            viewContext.delete(recipeToDelete)
            try viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    private func getFavoriteRecipes() {
        do {
            try recipeFetchController.performFetch()
            recipes.value = recipeFetchController.fetchedObjects ?? []
        } catch {
            NSLog(error.localizedDescription)
        }
    }

    private func getRecipes() -> [RecipeCoreData] {
        let fetchRequest: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()

        do {
            let recipes = try viewContext.fetch(fetchRequest)
            return recipes
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
            return []
        }
    }

}

// MARK: - NSFetchedResultsControllerDelegate
extension RecipeDetailRepository: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let recipes = controller.fetchedObjects as? [RecipeCoreData] else {
            return
        }
        print("Context has changed, reloading courses")
        self.recipes.value = recipes
    }

}
