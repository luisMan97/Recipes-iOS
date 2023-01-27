//
//  RecipesListFactory.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import UIKit
import Combine

enum RecipesListFactory {
    
    static func getRecipesListView(appContainer: AppContainerProtocol) -> RecipesListView {
        // DataSources
        let dataSource = RecipesListURLSessionDataSource(apiManager: appContainer.apiManager)
        let localDataSource = RecipeListCoreDataDataSource()
        // Repository
        let repository = RecipesListRepository(dataSource: dataSource,
                                               localDataSource: localDataSource)
        // Interactor
        let getRecipesListUseCase = GetRecipesListUseCase(repository: repository)
        let getRecipesByProductUseCase = GetRecipesByProductUseCase(repository: repository)
        let getFavoritesRecipes = GetFavoriteRecipesUseCase(repository: repository)
        let deleteFavoriteRecipesUseCase = DeleteFavoriteRecipeUseCase(repository: repository)
        let deleteAllRecipesUseCase = DeleteAllRecipesUseCase(repository: repository)
        // ViewModel
        let viewModel = RecipesListViewModel(getRecipesListUseCase: getRecipesListUseCase,
                                             getRecipesByProductUseCase: getRecipesByProductUseCase,
                                             getFavoritesRecipes: getFavoritesRecipes,
                                             deleteFavoriteRecipesUseCase: deleteFavoriteRecipesUseCase,
                                             deleteAllRecipesUseCase: deleteAllRecipesUseCase)
        return RecipesListView(viewModel: viewModel)
    }
    
}
