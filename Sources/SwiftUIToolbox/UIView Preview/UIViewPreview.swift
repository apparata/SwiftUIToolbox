//
//  Copyright © 2019 Apparata AB. All rights reserved.
//


#if canImport(SwiftUI) && canImport(UIKit) && DEBUG
import UIKit
import SwiftUI

@available(iOS 13.0, *)
public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    public let view: View
    public let direction: UISemanticContentAttribute

    public init(direction: UISemanticContentAttribute = .forceLeftToRight, _ builder: @escaping () -> View) {
        view = builder()
        self.direction = direction
    }

    // MARK: - UIViewRepresentable

    public func makeUIView(context: Context) -> UIView {
        return view
    }

    public func updateUIView(_ view: UIView, context: Context) {
        view.semanticContentAttribute = direction
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
