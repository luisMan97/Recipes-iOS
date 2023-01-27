//
//  RecipeDetailFactory.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation

enum RecipeDetailFactory {

    static func getRecipeDetailView(recipe: RecipeViewModel) -> RecipeDetilView {
        // repository
        let repository = RecipeDetailRepository()
        // interactor
        let viewModel = RecipeDetailViewModel(repository: repository)
        return RecipeDetilView(viewModel: viewModel, recipe: recipe)
    }

}
