//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

#if os(iOS)

import SwiftUI
import UIKit

// MARK: - AsyncImage

public struct AsyncImage<Placeholder: View, Failed: View>: View {
    
    @StateObject private var imageLoader = AsyncImageLoader()
    
    private let placeholder: Placeholder
    
    private let failed: Failed
    
    public init(url: URL,
                @ViewBuilder placeholder: () -> Placeholder,
                @ViewBuilder failed: () -> Failed) {
        self.placeholder = placeholder()
        self.failed = failed()
    }
    
    public var body: some View {
        switch imageLoader.state {
        case .ready: placeholder
        case .progressing: placeholder
        case .cancelled: failed
        case .failed: failed
        case .success(let image):
            Image(uiImage: image)
                .resizable()
        }
    }
}

#endif
