//
//  UINavigationBarAppearanceExtensions.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladin on 26/01/23.
//

import UIKit

extension UINavigationBarAppearance {

    func setup(backgroundColor: UIColor) -> UINavigationBarAppearance {

        let apperance = UINavigationBarAppearance()

        apperance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        apperance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        apperance.backgroundColor = backgroundColor

        return apperance
    }

}
