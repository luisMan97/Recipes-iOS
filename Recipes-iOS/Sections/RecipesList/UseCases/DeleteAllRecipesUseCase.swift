//
//  DeleteAllRecipesUseCase.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation

struct DeleteAllRecipesUseCase {

    // Repository
    private(set) var repository: RecipesListRepositoryProtocol

    // MARK: - Internal Methods

    func invoke() {
        repository.deleteAllRecipes()
    }

}
