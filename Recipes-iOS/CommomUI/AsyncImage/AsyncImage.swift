//
//  AsyncImage.swift
//  APOD-iOS-CLEAN
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    
    @StateObject private var loader: AsyncImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    private let contentMode: ContentMode
    
    init(url: URL,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:),
         contentMode: ContentMode = .fit
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: AsyncImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
        self.contentMode = contentMode
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!).aspectRatio(contentMode: contentMode)
            } else {
                placeholder
            }
        }
    }
}
