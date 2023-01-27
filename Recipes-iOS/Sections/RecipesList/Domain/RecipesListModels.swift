//
//  RecipesListModels.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import Foundation

struct RecipesRequest {
    let product: String
}

struct RecipesResponse: Decodable {
    let results: [RecipeResultResponse]?
}

extension RecipesResponse {
    
    func toDomain() -> [RecipeViewModel] {
        results?.compactMap { $0.toDomain() } ?? []
    }
    
}

struct RecipeResultResponse: Decodable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
}

extension RecipeResultResponse {
    
    func toDomain() -> RecipeViewModel {
        .init(id: id ?? 1,
              title: title ?? .empty,
              imageUrl: URL(string: image ?? .empty),
              readOnly: true)
    }
    
}

struct RecipeViewModel: Identifiable {
    let id: Int
    let title: String
    let imageUrl: URL?
    let readOnly: Bool
}

extension RecipeViewModel {
    
    func toCoreData(_ recipe: RecipeCoreData) {
        recipe.id = Int32(id)
        recipe.title = title
        recipe.image = imageUrl?.absoluteString ?? .empty
    }
    
}

extension RecipeCoreData {
    
    func toDomain() -> RecipeViewModel {
        .init(id: Int(id), title: title ?? .empty, imageUrl: URL(string: image ?? .empty), readOnly: false)
    }
    
}
