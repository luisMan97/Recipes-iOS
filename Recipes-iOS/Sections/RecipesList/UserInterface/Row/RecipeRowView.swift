//
//  RecipeRowView.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import SwiftUI

struct RecipeRowView: View {
    
    var recipe: RecipeViewModel
    var isFavorite: Bool

    var body: some View {
        HStack {
            if let imageURL = recipe.imageUrl {
                    AsyncImage(url: imageURL,
                               placeholder: { placeHolderImage },
                               image: { Image(uiImage: $0).resizable() })
                        .frame(width: 120, height: 120)
            }
            
            Spacer()
            
            VStack {
                Text(recipe.title)
                
                HStack {
                    Spacer()
                    
                    Image(systemName: isFavorite ? "star.fill" : "star")
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

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowView(recipe: RecipeViewModel(id: -1, title: "title", imageUrl: nil, readOnly: false), isFavorite: true)
    }
}
