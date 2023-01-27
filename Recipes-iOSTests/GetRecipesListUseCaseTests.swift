//
//  GetRecipesListUseCaseTests.swift
//  Recipes-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import XCTest

class GetRecipesListUseCaseTests: XCTestCase {

    private var repository: RecipesListRepositoryMock!
    private var useCase: GetRecipesListUseCase!
    
    override func setUp() {
        repository = RecipesListRepositoryMock()
        useCase = .init(repository: repository)
    }

    func testSomething() async {
        let expectedValue = RecipesList.Something.ViewModel(something: "something")
        repository.somethingInputResult = expectedValue
        let response = await useCase.invoke(request: .init())
        XCTAssertEqual(response, .success(expectedValue))
    }
    
    func testSomethingError() async {
        let expectedValue = RecipesList.Something.ViewModel(something: String())
        repository.somethingInputResult = expectedValue
        let response = await useCase.invoke(request: .init())
        XCTAssertEqual(response, .failure(UseCaseError.decodingError))
    }

}

// TODO: Move to other file
class RecipesListRepositoryMock: RecipesListRepositoryProtocol {
    
    var somethingInputResult: RecipesList.Something.ViewModel = .init(something: String())
    
    private var somethingOutputResult: RecipesList.Something.ViewModel {
        get throws { return try somethingResult() }
    }
    
    func doSomething(request: RecipesList.Something.Request) async throws -> RecipesList.Something.ViewModel {
        return try somethingOutputResult
    }
    
    private func somethingResult() throws -> RecipesList.Something.ViewModel {
        if somethingInputResult.something.isEmpty {
            throw APIServiceError.decodingError
        } else {
            return somethingInputResult
        }
    }
    
}

// TODO: Move to other file
extension RecipesList.Something.ViewModel: Equatable {
    
    static func == (lhs: RecipesList.Something.ViewModel, rhs: RecipesList.Something.ViewModel) -> Bool {
        lhs.something == rhs.something
    }
    
}
