//
//  DeleteFavoriteRecipeUseCase.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation

struct DeleteFavoriteRecipeUseCase {

    // Repository
    private(set) var repository: RecipesListRepositoryProtocol

    // MARK: - Internal Methods

    func invoke(favoriteRecipes: [RecipeCoreData], offsets: IndexSet) {
        repository.deleteFavoriteRecipes(favoriteRecipes: favoriteRecipes, offsets: offsets)
    }

}

