//
//  RemoteRecipesListDataSource.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

protocol RemoteRecipesListDataSource {
    func doSomething() async throws -> [RecipeViewModel]
    func getRecipesByProduct(request: RecipesRequest) async throws -> [RecipeViewModel]
}
