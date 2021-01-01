//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import SwiftUI
import UIKit

struct ViewControllerPresenter: View {
    
    @Binding var isPresented: Bool
    
    var viewController: () -> UIViewController
    
    init(isPresented: Binding<Bool>, viewController: @escaping () -> UIViewController) {
        self._isPresented = isPresented
        self.viewController = viewController
    }
    
    var body: some View {
        if isPresented {
            PresentingViewControllerWrapper(viewController: viewController)
        }
    }
}

struct PresentingViewControllerWrapper: UIViewControllerRepresentable {
    
    var viewController: () -> UIViewController
    
    init(viewController: @escaping () -> UIViewController) {
        self.viewController = viewController
    }
    
    public func makeUIViewController(context: Context) -> PresentingViewController {
        let presentingViewController = PresentingViewController.make()
        presentingViewController.delegate = context.coordinator
        return presentingViewController
    }
    
    public func updateUIViewController(_ uiViewController: PresentingViewController, context: UIViewControllerRepresentableContext<Self>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: PresentingViewControllerDelegate {
    
        var wrapper: PresentingViewControllerWrapper
        
        var viewController: () -> UIViewController
    
        init(_ wrapper: PresentingViewControllerWrapper) {
            self.wrapper = wrapper
            self.viewController = wrapper.viewController
        }
    
        // MARK: Delegate Methods
        
        func viewControllerToPresent() -> UIViewController {
            wrapper.viewController()
        }
    }
}

protocol PresentingViewControllerDelegate: AnyObject {
    
    func viewControllerToPresent() -> UIViewController
}

class PresentingViewController: UIViewController {
    
    weak var delegate: PresentingViewControllerDelegate?
    
    static func make() -> PresentingViewController {
        let viewController = PresentingViewController()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let viewController = delegate?.viewControllerToPresent() else {
            return
        }
        present(viewController, animated: true)
    }
}

#endif
