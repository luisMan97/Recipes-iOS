//
//  RecipesListViewModelTests.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import XCTest

class RecipesListViewModelTests: XCTestCase {

    private var viewModel: RecipesListViewModel!
    private var getRecipesListUseCase: GetRecipesListUseCaseMock!
    
    override func setUp() {
        getRecipesListUseCase = GetRecipesListUseCaseMock()
        viewModel = RecipesListViewModel(getRecipesListUseCase: getRecipesListUseCase)
    }

    func testSomething() async {
        let expectedValue = RecipesList.Something.ViewModel(something: "something")
        getRecipesListUseCase.executeResult = .success(expectedValue)
        await viewModel.doSomething()
        XCTAssertEqual(viewModel.RecipesList, expectedValue)
    }
    
    func testSomethingError() async {
        getRecipesListUseCase.executeResult = .failure(UseCaseError.decodingError)
        await viewModel.doSomething()
        XCTAssertEqual(viewModel.error, UseCaseError.decodingError.localizedDescription)
    }

}

// TODO: Move to other file
class GetRecipesListUseCaseMock: GetRecipesListUseCaseProtocol {
    
    var executeResult: Result<RecipesList.Something.ViewModel, UseCaseError> = .success(.init(something: String()))
    
    func invoke(request: RecipesList.Something.Request) async -> Result<RecipesList.Something.ViewModel, UseCaseError> {
        return executeResult
    }
    
}
