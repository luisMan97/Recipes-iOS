//
//  LocalRecipesListDataSource.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation
import Combine

protocol LocalRecipesListDataSource {
    var recipes: CurrentValueSubject<[RecipeCoreData], Never> { get }
    func deleteFavoriteRecipes(favoriteRecipes: [RecipeCoreData], offsets: IndexSet)
    func deleteAllRecipes()
}
