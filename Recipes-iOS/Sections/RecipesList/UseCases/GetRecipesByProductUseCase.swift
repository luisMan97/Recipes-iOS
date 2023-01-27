//
//  GetRecipesByProductUseCase.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 27/01/23.
//

import Foundation

protocol GetRecipesByProductUseCaseProtocol {
    func invoke(request: RecipesRequest) async -> Result<[RecipeViewModel], UseCaseError>
}

struct GetRecipesByProductUseCase: GetRecipesByProductUseCaseProtocol {
    
    // Repository
    private(set) var repository: RecipesListRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke(request: RecipesRequest) async -> Result<[RecipeViewModel], UseCaseError> {
        do {
            let something = try await repository.getRecipesByProduct(request: request)
            return .success(something)
        } catch {
            return .failure(handleError(error))
        }
    }
    
    // MARK: - Private Methods
    
    private func handleError(_ error: Error) -> UseCaseError {
        switch(error) {
        case APIServiceError.decodingError: return .decodingError
        default: return .networkError
        }
    }

}
