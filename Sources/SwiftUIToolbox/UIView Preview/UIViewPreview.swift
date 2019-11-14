//
//  Copyright © 2019 Apparata AB. All rights reserved.
//


#if canImport(SwiftUI) && canImport(UIKit) && DEBUG
import UIKit
import SwiftUI

@available(iOS 13.0, *)
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    let direction: UISemanticContentAttribute

    init(direction: UISemanticContentAttribute = .forceLeftToRight, _ builder: @escaping () -> View) {
        view = builder()
        self.direction = direction
    }

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.semanticContentAttribute = direction
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
