//
//  View+SearchBar.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 27/01/23.
//

import SwiftUI

extension View {
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func conditionalModifier<Content: View>(_ condition: Bool,
                                                         transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    typealias ContentTransform<Content: View> = (Self) -> Content
    @ViewBuilder
    func conditionalModifier<TrueContent: View, FalseContent: View>(_ condition: Bool,
                                                                                 ifTrue: ContentTransform<TrueContent>,
                                                                                 ifFalse: ContentTransform<FalseContent>) -> some View {
        if condition {
            ifTrue(self)
        } else {
            ifFalse(self)
        }
    }
    
    func add(_ searchBar: SearchBar, showSearchBar: Binding<Bool> = .constant(true)) -> some View {
        self.modifier(SearchBarModifier(searchBar: searchBar, showSearchBar: showSearchBar))
    }

}
