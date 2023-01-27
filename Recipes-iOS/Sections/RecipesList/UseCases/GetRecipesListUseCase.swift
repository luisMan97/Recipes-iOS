//
//  GetRecipesListUseCase.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import Foundation

enum UseCaseError: Error {
    case networkError, decodingError
    
    public var localizedDescription: String {
        switch self {
        case .networkError:
            return "Verifica tu conexión a internet e intenta nuevamente."
        case .decodingError:
            return "Ha ocurrido un error, inténtalo en unos minutos."
        }
    }
}

protocol GetRecipesListUseCaseProtocol {
    func invoke() async -> Result<[RecipeViewModel], UseCaseError>
}

struct GetRecipesListUseCase: GetRecipesListUseCaseProtocol {
    
    // Repository
    private(set) var repository: RecipesListRepositoryProtocol
    
    // MARK: - Internal Methods
    
    func invoke() async -> Result<[RecipeViewModel], UseCaseError> {
        do {
            let something = try await repository.doSomething()
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
