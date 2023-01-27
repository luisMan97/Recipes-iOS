//
//  RecipeListRepositoryMock.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Combine
import Foundation
@testable import Recipes_iOS

class RecipeListRepositoryMock: RecipesListRepositoryProtocol {

    var recipesSub: [RecipeViewModel] = []
    let favoriteRecipesSub = PassthroughSubject<[RecipeCoreData], Never>()
    
    func doSomething() async throws -> [RecipeViewModel] {
        recipesSub
    }
    
    func getFavoriteRecipes() -> AnyPublisher<[RecipeCoreData], Never> {
        favoriteRecipesSub.eraseToAnyPublisher()
    }
    
    func deleteFavoriteRecipes(favoriteRecipes: [RecipeCoreData], offsets: IndexSet) { }
    
    func deleteAllRecipes() { }

}
