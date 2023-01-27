//
//  RecipesListView.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import SwiftUI

struct RecipesListView: View {
    
    @ObservedObject var viewModel: RecipesListViewModel
    
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        LoadingView(isShowing: $viewModel.showProgress, text: viewModel.progressTitle) {
            NavigationView {
                VStack {
                    Picker(String(),
                           selection: $viewModel.selectorIndex.onChange(segmentedChanged)) {
                        ForEach(viewModel.pickerOptionsRange, id: \.self) { index in
                            Text(viewModel.pickerOptions[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top)
                    
                    if viewModel.recipesList.isEmpty {
                        Text(viewModel.emptyText)
                            .font(.system(.title3, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        List {
                            ForEach(viewModel.recipesList) { recipe in
                                NavigationLink {
                                    RecipeDetailFactory.getRecipeDetailView(recipe: recipe)
                                        .deleteDisabled(recipe.readOnly)
                                } label: {
                                    RecipeRowView(recipe: recipe,
                                                  isFavorite: viewModel.favoritesRecipes.filter( { $0.id == Int32(recipe.id) } ).isNotEmpty)
                                }
                            }.onDelete(perform: deleteItems)
                        }
                    }
                    
                    Spacer()
                }
                .add(viewModel.searchBar)
                .navigationBarTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        rightButton
                    }
                }.environment(\.editMode, $editMode)
            }
        }
        .alert(item: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text($0),
                  dismissButton: .default(Text("Ok"))
            )
        }
        .onChange(of: viewModel.favoritesRecipes) { newValue in
            if editMode == .active && viewModel.favoritesRecipes.isEmpty {
                Task { await viewModel.doSomething() }
                editMode = .inactive
            }
        }
        .task {
            await viewModel.doSomething()
        }
    }
    
    private var rightButton: some View {
        return Group {
            switch viewModel.showFavorites {
            case true:
                editButton
            case false:
                Button(action: getRecipes, label: {
                    Image(systemName: "arrow.clockwise")
                })
            }
        }
    }
    
    private var editButton: some View {
        return Group {
            switch editMode {
            case .inactive:
                if viewModel.favoritesRecipes.isEmpty {
                    EmptyView()
                } else {
                    EditButton()
                }
            case .active:
                EditButton()
            default:
                EmptyView()
            }
        }
    }
    
    private func getRecipes() {
        Task { await viewModel.doSomething() }
    }
    
    private func segmentedChanged(to value: Int) {
        if value == 0 {
            editMode = .inactive
        }
        viewModel.segmentedChanged(to: value)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation { viewModel.deleteFavoriteRecipes(offsets: offsets) }
    }
    
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListFactory.getRecipesListView(appContainer: AppContainer())
    }
}
