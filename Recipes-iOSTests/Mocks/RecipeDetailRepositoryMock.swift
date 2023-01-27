//
//  RecipeDetailRepositoryMock.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation
import Combine
@testable import Recipes_iOS

class RecipeDetailRepositoryMock: RecipeDetailRepositoryProtocol {
    var recipes = CurrentValueSubject<[RecipeCoreData], Never>([])
    
    func saveRecipe(_ recipe: RecipeViewModel) { }

}
