//
//  RecipeDetilView.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import SwiftUI
import CoreData

struct RecipeDetilView: View {

    @ObservedObject var viewModel: RecipeDetailViewModel
    var recipe: RecipeViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if let imageURL = recipe.imageUrl {
                    VStack {
                        AsyncImage(url: imageURL,
                                   placeholder: { placeHolderImage },
                                   image: { Image(uiImage: $0).resizable() })
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        
                        Spacer()
                    }
                }
                
                Text(recipe.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .alert(item: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text($0),
                  dismissButton: .default(Text("Ok"))
            )
        }
        .navigationBarTitle("Receta")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button(action: { viewModel.saveRecipe(recipe) }) {
                    let localRecipes = viewModel.favoriteRecipes.filter { $0.id == recipe.id }
                    Label("Add Item", systemImage: localRecipes.isEmpty ? "star" : "star.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
    
    private var placeHolderImage: some View {
        ZStack {
            Color(.lightGray)
            
            Text("Cargando...")
                .foregroundColor(.gray)
        }
        .frame(width: 120, height: 120)
        .cornerRadius(10)
    }

}


