//
//  RecipesListURLSessionDataSource.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

enum APIServiceError: Error {
    case badUrl, requestError, decodingError, statusNotOK
}

struct RecipesListURLSessionDataSource: RemoteRecipesListDataSource {
    
    let apiManager: APIManagerProtocol
    
    func doSomething() async throws -> [RecipeViewModel] {
        try await fetchRecipes().toDomain()
    }
    
}

private extension RecipesListURLSessionDataSource {

    func fetchRecipes() async throws -> RecipesResponse {
        try await apiManager.request(service: .Recipes)
    }

}
