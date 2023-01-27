//
//  ImageCacheKey.swift
//  APOD-iOS-CLEAN
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
