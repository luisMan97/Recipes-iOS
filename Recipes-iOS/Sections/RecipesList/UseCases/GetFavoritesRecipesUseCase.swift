//
//  GetFavoriteRecipesUseCase.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation
import Combine

protocol GetFavoriteRecipesUseCaseProtocol {
    func invoke() -> AnyPublisher<[RecipeCoreData], Never>
}

struct GetFavoriteRecipesUseCase: GetFavoriteRecipesUseCaseProtocol {

    // Repository
    private(set) var repository: RecipesListRepositoryProtocol

    // MARK: - Internal Methods

    func invoke() -> AnyPublisher<[RecipeCoreData], Never> {
        repository.getFavoriteRecipes()
    }

}
