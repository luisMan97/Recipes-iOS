//
//  RecipesListViewModel.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import Foundation
import Combine

class RecipesListViewModel: ObservableObject {
    
    // Internal Output Events Properties
    @Published var showProgress = false
    @Published var recipesList: [RecipeViewModel] = []
    @Published var favoritesRecipes: [RecipeCoreData] = []
    @Published var error: String?
    @Published var showFavorites: Bool = false
    
    // Internal Properties
    var progressTitle = ""
    var pickerOptions = ["Recetas", "Favoritos"]
    var selectorIndex = 0
    
    var pickerOptionsRange: Range<Int> { 0..<pickerOptionsCount }
    var title: String { showFavorites ? "Recetas Favoritas" : "Recetas" }
    var emptyText: String { showFavorites ? "No tienes favoritos guardados" : "No se han encontrado recetas, intenta nuevamente" }
    
    // Private Properties
    private var subscriptions: Set<AnyCancellable> = []
    private var originalRecipesList: [RecipeViewModel] = []
    
    private var pickerOptionsCount: Int { pickerOptions.count }
    
    // Interactor
    private var getRecipesListUseCase: GetRecipesListUseCaseProtocol
    private var getFavoritesRecipes: GetFavoriteRecipesUseCaseProtocol
    private var deleteFavoriteRecipesUseCase: DeleteFavoriteRecipeUseCase
    private var deleteAllRecipesUseCase: DeleteAllRecipesUseCase
    
    // MARK: - Initializers
    
    init(getRecipesListUseCase: GetRecipesListUseCaseProtocol,
         getFavoritesRecipes: GetFavoriteRecipesUseCaseProtocol,
         deleteFavoriteRecipesUseCase: DeleteFavoriteRecipeUseCase,
         deleteAllRecipesUseCase: DeleteAllRecipesUseCase) {
        self.getRecipesListUseCase = getRecipesListUseCase
        self.getFavoritesRecipes = getFavoritesRecipes
        self.deleteFavoriteRecipesUseCase = deleteFavoriteRecipesUseCase
        self.deleteAllRecipesUseCase = deleteAllRecipesUseCase
        getFavoriteRecipes()
    }
    
    // MARK: - Internal Methods
    
    @MainActor
    func doSomething() async {
        progressTitle = "Cargando..."
        showProgress = true
        
        let result = await getRecipesListUseCase.invoke()
        
        switch result {
        case .success(let recipesList):
            initializeRecipesList(recipesList)
            originalRecipesList = self.recipesList
            showProgress = false
        case .failure(let error):
            self.error = error.localizedDescription
            showProgress = false
        }
    }
    
    func deleteFavoriteRecipes(offsets: IndexSet) {
        deleteFavoriteRecipesUseCase.invoke(favoriteRecipes: favoritesRecipes, offsets: offsets)
    }

    func deleteAllRecipes() {
        deleteAllRecipesUseCase.invoke()
        Task { await doSomething() }
    }
    
    func segmentedChanged(to value: Int) {
        showFavorites = value == 1
        initializeRecipesList(originalRecipesList)
        originalRecipesList = self.recipesList
        recipesList = showFavorites ? favoritesRecipes.map { $0.toDomain() } : originalRecipesList
    }
    
    // MARK: - Private Methods

    private func getFavoriteRecipes() {
        getFavoritesRecipes.invoke()
            .sink { [weak self] favoriteRecipes in
                guard let self = self else { return }
                self.favoritesRecipes = favoriteRecipes
                
                if self.showFavorites {
                    self.initializeRecipesList(self.favoritesRecipes.map { $0.toDomain() })
                } else {
                    self.initializeRecipesList(self.originalRecipesList)
                }
                
        }.store(in: &subscriptions)
    }
    
    private func initializeRecipesList(_ recipesList: [RecipeViewModel]) {
        let favoriteRecipesIds = favoritesRecipes.map { Int($0.id) }
        let noFavoriteRecipes = recipesList.filter( { !favoriteRecipesIds.contains($0.id) } )
        self.recipesList = recipesList.filter( { favoriteRecipesIds.contains($0.id) } )
        self.recipesList.append(contentsOf: noFavoriteRecipes)
    }

}
