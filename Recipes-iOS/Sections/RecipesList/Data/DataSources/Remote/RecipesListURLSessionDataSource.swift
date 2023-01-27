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
    
    func getRecipes() async throws -> [RecipeViewModel] {
        try await fetchRecipes().toDomain()
    }

    func getRecipesByProduct(request: RecipesRequest) async throws -> [RecipeViewModel] {
        try await fetchRecipesByProduct(request: request).toDomain()
    }

}

private extension RecipesListURLSessionDataSource {

    func fetchRecipes() async throws -> RecipesResponse {
        try await apiManager.request(service: .DefaultRecipes)
    }

    func fetchRecipesByProduct(request: RecipesRequest) async throws -> RecipesResponse {
        let parameters = [
            "product": request.product
        ] as [String: Any]
        return try await apiManager.request(service: .Recipes(parameters))
    }

}
