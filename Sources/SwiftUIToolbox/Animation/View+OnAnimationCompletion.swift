//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

extension View {

    /// Action closure is called when an animation affecting the specified value completes.
    ///
    /// Example:
    ///
    /// ```
    /// @State var textOpacity: CGFloat
    ///
    /// Text("Whatever")
    ///     .opacity(introTextOpacity)
    ///     .onAnimationCompletion(for: introTextOpacity) {
    ///         print("Animation completed")
    ///     }
    /// ```
    ///
    /// - Parameter value: The value to observe for animations.
    /// - Parameter action: Called when the animation has completed.
    /// - Returns: A modified `View` instance with the observer attached.
    ///
    func onAnimationCompletion<Value: VectorArithmetic>(for value: Value, action: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(value: value, action: action))
    }
}

struct AnimationCompletionObserverModifier<Value>: ViewModifier, @preconcurrency Animatable where Value: VectorArithmetic {

    // Property is set once the animation is completed.
    var animatableData: Value {
        didSet {
            performAction()
        }
    }

    private var targetValue: Value

    private var action: () -> Void

    init(value: Value, action: @escaping () -> Void) {
        self.action = action
        self.animatableData = value
        targetValue = value
    }

    private func performAction() {
        guard animatableData == targetValue else {
            return
        }

        DispatchQueue.main.async {
            self.action()
        }
    }

    func body(content: Content) -> some View {
        content
    }
}
