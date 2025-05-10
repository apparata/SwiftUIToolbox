//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

import SwiftUI

/// A SwiftUI view that injects values into a model at initialization time.
///
/// This view runs an injection closure immediately during its initialization, allowing models to receive
/// references to view-level services or data.
///
/// It is typically used together with the `@InjectedFromView` property wrapper in models.
///
/// Example:
///
/// ```swift
/// struct SomeView: View {
///     @Environment(SomeService.self) var someService
///
///     var body: some View {
///         InjectingIntoModel {
///             model.someService = someService
///         } for: {
///             content
///         }
///     }
///
///     @ViewBuilder var content: some View {
///         // ...
///     }
/// }
///
/// @Observable class SomeModel {
///     @InjectedFromView var someService: SomeService
/// }
/// ```
struct InjectingIntoModel<Content: View>: View {
    private let content: Content

    init(_ injection: @escaping () -> Void, @ViewBuilder for content: () -> Content) {
        injection()
        self.content = content()
    }

    var body: some View {
        content
    }
}

/// A property wrapper that allows a model object to receive values injected from a SwiftUI view.
///
/// This is intended to be used in conjunction with `InjectingIntoModel`, which injects values into a model
/// when the view is created. If the value is accessed before being injected, a runtime error will occur.
///
/// Example usage:
///
/// ```swift
/// @Observable class SomeModel {
///     @InjectedFromView var someService: SomeService
/// }
/// ```
///
/// The value is typically set in the view using `InjectingIntoModel`:
///
/// ```swift
/// InjectingIntoModel {
///     model.someService = someService
/// } for: {
///     content
/// }
/// ```
@propertyWrapper
struct InjectedFromView<T> {
    private var value: T?

    /// The value injected from the view. Accessing this before it is set will trigger a fatal error.
    var wrappedValue: T {
        get {
            guard let value = value else {
                fatalError("InjectedFromView: Attempted to access \(T.self) before it was set.")
            }
            return value
        }
        set {
            value = newValue
        }
    }

    /// Initializes the property wrapper with a pre-set value. Primarily for testing or previews.
    init(wrappedValue: T) {
        self.value = wrappedValue
    }

    init() { }
}
