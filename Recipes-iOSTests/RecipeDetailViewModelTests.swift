//
//  RecipeDetailViewModelTests.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import XCTest
@testable import Recipes_iOS

class RecipeDetailViewModelTests: XCTestCase {

    private var repositoryMock = RecipeDetailRepositoryMock()
    private lazy var recipeDetailInteractor: RecipeDetailViewModel = {
        let recipeDetailInteractor = RecipeDetailViewModel(repository: RecipeDetailRepository())
        XCTAssertNotNil(recipeDetailInteractor)
        return recipeDetailInteractor
    }()

}
