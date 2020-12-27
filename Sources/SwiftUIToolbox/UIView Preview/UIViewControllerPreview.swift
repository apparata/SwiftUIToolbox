//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

#if canImport(SwiftUI) && canImport(UIKit) && DEBUG
import SwiftUI
import UIKit

/// Allows for objects that inherit from  `UIViewController` to be previewed in the SwiftUI preview
/// window in Xcode.
@available(iOS 13.0, *)
public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    public let viewController: ViewController

    public init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    public func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {
        return
    }
}
#endif
