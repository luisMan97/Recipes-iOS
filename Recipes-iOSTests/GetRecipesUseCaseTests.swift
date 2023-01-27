//
//  GetRecipesUseCaseTests.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import XCTest
import Combine
@testable import Recipes_iOS

class GetRecipesUseCaseTests: XCTestCase {

    private var repositoryMock = RecipeListRepositoryMock()
    private lazy var getRecipesUseCaseTests: GetRecipesListUseCase = {
        let getRecipesUseCaseTests = GetRecipesListUseCase(repository: repositoryMock)
        XCTAssertNotNil(getRecipesUseCaseTests)
        return getRecipesUseCaseTests
    }()

    func testGetRecipes() async {
        // Given
        let expectedValues: [RecipeViewModel] = [
            RecipeViewModel(id: -1, title: "Arroz con leche", imageUrl: nil, readOnly: true)
        ]
        repositoryMock.recipesSub = expectedValues
        // When
        let result = await getRecipesUseCaseTests.invoke()
        // Then
        switch result {
        case .success(let recipes):
            XCTAssertEqual(recipes, expectedValues)
        case .failure(_): break
        }
    }

}
