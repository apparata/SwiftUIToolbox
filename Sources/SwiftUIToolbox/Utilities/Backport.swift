//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

import SwiftUI

public struct Backport<Content> {
    public let content: Content

    public init(_ content: Content) {
        self.content = content
    }
}

extension View {
    /// Example:
    /// ```swift
    /// extension Backport where Content: View {
    ///     @ViewBuilder func badge(_ count: Int) -> some View {
    ///         if #available(iOS 15, *) {
    ///             content.badge(count)
    ///         } else {
    ///             content
    ///         }
    ///     }
    ///}
    ///
    /// someView.backport.badge(5)
    /// ```
    public var backport: Backport<Self> {
        Backport(self)
    }
}
