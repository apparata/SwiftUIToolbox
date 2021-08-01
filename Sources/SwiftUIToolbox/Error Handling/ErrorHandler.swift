//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

public struct ViewErrorBeingHandled: Identifiable {
    public let id = UUID()
    public let title: String?
    public let message: String
    public let didHandle: (() -> Void)?
}

public class ViewErrorHandler: ObservableObject {
    
    @Published public var currentError: ViewErrorBeingHandled?
    
    public init() {
        //
    }
    
    public func handleError(_ error: Error) {
        handleError(error, title: nil, didHandle: nil)
    }

    public func handleError(_ error: Error, title: String?) {
        handleError(error, title: title, didHandle: nil)
    }

    public func handleError(_ error: Error, didHandle: (() -> Void)?) {
        handleError(error, title: nil, didHandle: didHandle)
    }

    public func handleError(_ error: Error, title: String?, didHandle: (() -> Void)?) {
        currentError = ViewErrorBeingHandled(title: title,
                                             message: error.localizedDescription,
                                             didHandle: didHandle)
    }
}

extension View {
    public func errorHandling<T: ViewErrorHandling>(_ handling: T) -> some View {
        modifier(handling)
    }
}

public protocol ViewErrorHandling: ViewModifier {
    var errorHandler: ViewErrorHandler { get }
}

public struct AlertViewErrorHandling: ViewErrorHandling {
    
    @StateObject public var errorHandler = ViewErrorHandler()
    
    public init() {
        //
    }
    
    public func body(content: Content) -> some View {
        content
            .environmentObject(errorHandler)
            .background(alertAttachment()) // Kludge
    }
    
    private func alertAttachment() -> some View {
        EmptyView()
            .alert(item: $errorHandler.currentError) { error in
                Alert(title: Text(error.title ?? "Error"),
                      message: Text(error.message),
                      dismissButton: .default(Text("OK")) {
                    error.didHandle?()
                })
            }
    }
}
