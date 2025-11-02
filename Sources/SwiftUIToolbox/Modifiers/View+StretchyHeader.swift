//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import SwiftUI

extension View {

    /// Adds a stretchy header effect to a view.
    ///
    /// Use this modifier on an image or other view inside a `ScrollView` to create a dynamic,
    /// stretching effect when the user pulls down on the scroll view content.
    ///
    /// ### Example
    ///
    /// ```swift
    /// ScrollView {
    ///     VStack {
    ///         Image("someImage")
    ///             .resizable()
    ///             .scaledToFill()
    ///             .stretchyHeader()
    ///         Text("Hello there")
    ///     }
    /// }
    /// .ignoresSafeArea(edges: .top)
    /// ```
    ///
    /// The modifier scales the view proportionally based on the scroll offset, creating
    /// a natural stretch effect anchored at the bottom edge. This is commonly used for
    /// large images at the top of scrollable content.
    ///
    /// - Returns: A view that stretches vertically in response to downward scrolling.
    ///
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    public func stretchyHeader() -> some View {
        visualEffect { effect, geometry in
            let currentHeight = geometry.size.height
            let scrollOffset = geometry.frame(in: .scrollView).minY
            let positiveOffset = max(0, scrollOffset)

            let newHeight = currentHeight + positiveOffset
            let scaleFactor = newHeight / currentHeight

            return effect.scaleEffect(
                x: scaleFactor,
                y: scaleFactor,
                anchor: .bottom
            )
        }
    }
}
