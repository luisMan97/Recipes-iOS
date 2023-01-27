//
//  RecipesListRepository.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import Foundation
import Combine

protocol RecipesListRepositoryProtocol {
    func doSomething() async throws -> [RecipeViewModel]
    func getFavoriteRecipes() -> AnyPublisher<[RecipeCoreData], Never>
    func deleteFavoriteRecipes(favoriteRecipes: [RecipeCoreData], offsets: IndexSet)
    func deleteAllRecipes()
}

struct RecipesListRepository: RecipesListRepositoryProtocol {
    
    private(set) var dataSource: RemoteRecipesListDataSource
    private(set) var localDataSource: LocalRecipesListDataSource
    
    func doSomething() async throws -> [RecipeViewModel] {
        return try await dataSource.doSomething()
    }
    
    func getFavoriteRecipes() -> AnyPublisher<[RecipeCoreData], Never> {
        localDataSource.recipes.eraseToAnyPublisher()
    }
    
    func deleteFavoriteRecipes(favoriteRecipes: [RecipeCoreData], offsets: IndexSet) {
        localDataSource.deleteFavoriteRecipes(favoriteRecipes: favoriteRecipes, offsets: offsets)
    }

    func deleteAllRecipes() {
        localDataSource.deleteAllRecipes()
    }
    
}
