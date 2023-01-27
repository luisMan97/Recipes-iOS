//
//  SplashView.swift
//  Recipes-iOS
//
//  Created by Wilson David Molina Lozano on 27/01/23.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive: Bool = false
    @State private var width: CGFloat = 45
    @State private var height: CGFloat = 55
    
    var body: some View {
        ZStack {
            if isActive {
                RecipesListFactory.getRecipesListView(appContainer: AppContainer())
            } else {
                Color.red
                    .ignoresSafeArea()
                
                Image("salad")
                    .resizable()
                    .frame(width: width, height: height)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.default) {
                    self.width += 200
                    self.height += 200
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
