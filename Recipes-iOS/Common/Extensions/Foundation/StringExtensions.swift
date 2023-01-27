//
//  StringExtensions.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import Foundation

extension String {
    static var empty: String { String() }
}

extension String: Identifiable {
    public var id: String { self }
}
