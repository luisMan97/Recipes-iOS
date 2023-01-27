//
//  Recipes_iOSApp.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 25/01/23.
//

import SwiftUI

@main
struct Recipes_iOSApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        UINavigationBar().setup(backgroundColor: .red)
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
