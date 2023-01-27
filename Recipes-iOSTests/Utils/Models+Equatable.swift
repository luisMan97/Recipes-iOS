//
//  Models+Equatable.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 26/01/232.
//

import Foundation
@testable import Recipes_iOS

// MARK: - RecipeViewModel Equatable
extension RecipeViewModel: Equatable {

    public static func == (lhs: RecipeViewModel, rhs: RecipeViewModel) -> Bool {
        lhs.id == rhs.id
        && lhs.imageUrl == rhs.imageUrl
        && lhs.readOnly == rhs.readOnly
        && lhs.title == rhs.title
    }

}
