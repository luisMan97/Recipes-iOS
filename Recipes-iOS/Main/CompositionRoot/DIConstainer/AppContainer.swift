//
//  AppContainer.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import Foundation

protocol AppContainerProtocol {
    var apiManager: APIManagerProtocol { get }
}

struct AppContainer: AppContainerProtocol {
    var apiManager: APIManagerProtocol = APIManager()
}
