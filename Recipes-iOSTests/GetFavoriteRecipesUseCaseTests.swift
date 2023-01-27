//
//  GetFavoriteRecipesUseCaseTests.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import XCTest
import Combine
@testable import Recipes_iOS

class GetFavoriteRecipesUseCaseTests: XCTestCase {

    private var repositoryMock = RecipeListRepositoryMock()
    private lazy var getFavoriteRecipesUseCase: GetFavoriteRecipesUseCase = {
        let getFavoriteRecipesUseCase = GetFavoriteRecipesUseCase(repository: repositoryMock)
        XCTAssertNotNil(getFavoriteRecipesUseCase)
        return getFavoriteRecipesUseCase
    }()

    func testGetFavoriteRecipes() {
        let recipeViewModel = RecipeViewModel(id: -1, title: "Arroz con leche", imageUrl: nil, readOnly: true)
        let recipe = RecipeCoreData(context: PersistenceController.preview.managedContext)
        recipeViewModel.toCoreData(recipe)
        let expectedValues: [RecipeCoreData] = [
            recipe
        ]
        var recievedValues: [RecipeCoreData] = []

        let exp = expectation(description: "expected values")

        let cancelable = getFavoriteRecipesUseCase.invoke()
            .sink(receiveCompletion: { (subscriptionCompletion: Subscribers.Completion<Never>) in

            }, receiveValue: { (value) in
                recievedValues = value
                if recievedValues == expectedValues {
                    exp.fulfill()
                }
            })

        repositoryMock.favoriteRecipesSub.send([recipe])
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(cancelable)
    }

}
