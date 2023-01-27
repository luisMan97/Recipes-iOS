//
//  SearchBarModifier.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 27/01/23.
//

import SwiftUI

struct SearchBarModifier: ViewModifier {
    
    let searchBar: SearchBar
    @Binding var showSearchBar: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = showSearchBar ? self.searchBar.searchController : nil
                }.frame(width: 0, height: 0)
            )
    }
    
}
