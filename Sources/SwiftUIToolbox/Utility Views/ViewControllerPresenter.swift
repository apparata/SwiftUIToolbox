//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import SwiftUI
import UIKit

@MainActor public struct ViewControllerPresenter: View {

    @Binding public var isPresented: Bool
    
    public var viewController: () -> UIViewController
    
    public init(isPresented: Binding<Bool>, viewController: @escaping () -> UIViewController) {
        self._isPresented = isPresented
        self.viewController = viewController
    }
    
    public var body: some View {
        if isPresented {
            PresentingViewControllerWrapper(viewController: viewController)
        }
    }
}

@MainActor public struct PresentingViewControllerWrapper: UIViewControllerRepresentable {

    var viewController: () -> UIViewController
    
    public init(viewController: @escaping () -> UIViewController) {
        self.viewController = viewController
    }
    
    public func makeUIViewController(context: Context) -> PresentingViewController {
        let presentingViewController = PresentingViewController.make()
        presentingViewController.delegate = context.coordinator
        return presentingViewController
    }
    
    public func updateUIViewController(_ uiViewController: PresentingViewController, context: UIViewControllerRepresentableContext<Self>) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    
    @MainActor public class Coordinator: @preconcurrency PresentingViewControllerDelegate {

        public var wrapper: PresentingViewControllerWrapper
        
        public var viewController: () -> UIViewController
    
        public init(_ wrapper: PresentingViewControllerWrapper) {
            self.wrapper = wrapper
            self.viewController = wrapper.viewController
        }
    
        // MARK: Delegate Methods
        
        public func viewControllerToPresent() -> UIViewController {
            wrapper.viewController()
        }
    }
}

public protocol PresentingViewControllerDelegate: AnyObject {
    
    func viewControllerToPresent() -> UIViewController
}

public class PresentingViewController: UIViewController {
    
    public weak var delegate: PresentingViewControllerDelegate?
    
    public static func make() -> PresentingViewController {
        let viewController = PresentingViewController()
        return viewController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let viewController = delegate?.viewControllerToPresent() else {
            return
        }
        present(viewController, animated: true)
    }
}

#endif
