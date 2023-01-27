//
//  RecipeDetailViewModel.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Combine

class RecipeDetailViewModel: ObservableObject {
    
    @Published var error: String?
    @Published var favoriteRecipes: [RecipeCoreData] = []

    // MARK: - Private Properties

    private var repository: RecipeDetailRepositoryProtocol

    // MARK: - Private Properties

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(repository: RecipeDetailRepositoryProtocol) {
        self.repository = repository
        getFavoriteRecipes()
    }

    // MARK: - Internal Methods


    func saveRecipe(_ recipe: RecipeViewModel) {
        repository.saveRecipe(recipe)
    }

    private func getFavoriteRecipes() {
        repository.recipes
            .sink { [weak self] favoriteRecipes in
                self?.favoriteRecipes = favoriteRecipes
        }.store(in: &subscriptions)
    }

}
