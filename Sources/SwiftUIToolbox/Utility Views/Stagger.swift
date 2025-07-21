//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import SwiftUI

/// A container view that applies staggered transitions to its child views.
///
/// Use `Stagger` when you want to animate the appearance or disappearance of multiple views
/// with a delay between each, using a specified behavior.
///
@available(iOS 18.0, *)
public struct Stagger<Content: View>: View {

    /// Defines how the staggered transition should behave.
    public var behavior: StaggerBehavior

    /// The content views that will be animated with the stagger effect.
    public var content: Content

    /// Creates a new `Stagger` view.
    ///
    /// - Parameters:
    ///   - behavior: The configuration defining how the animation should be staggered.
    ///   - content: A closure returning the content views to be animated.
    init(
        _ behavior: StaggerBehavior,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.behavior = behavior
        self.content = content()
    }

    public var body: some View {
        Group(subviews: content) { collection in
            ForEach(collection.indices, id: \.self) { index in
                collection[index]
                    .transition(
                        StaggerTransition(
                            index: index,
                            behavior: behavior
                        )
                    )
            }
        }
    }
}

// MARK: - Stagger Behavior

/// Defines the behavior parameters for a `Stagger` animation.
///
/// Use this to customize timing, offset, scale, and animation curve for staggered transitions.
@available(iOS 18.0, *)
public struct StaggerBehavior: Equatable {
    /// Delay between each view’s animation start.
    public var delay: Double = 0.05

    /// Maximum total delay applied to the last view.
    public var maxDelay: Double = 0.4

    /// Blur radius applied to views before they appear.
    public var blurRadius: CGFloat = 6

    /// Offset applied to views before they appear or disappear.
    public var offset: CGSize = CGSize(width: 0, height: 100)

    /// Scale factor applied to views before they appear.
    public var scale: CGFloat = 0.95

    /// Anchor point used for scaling.
    public var scaleAnchor: UnitPoint = .center

    /// The animation curve used for the transition.
    public var animation: Animation = .interpolatingSpring

    /// Whether views should disappear in the same direction as they appeared.
    public var disappearInSameDirection: Bool = false

    /// Whether the disappearance transition should ignore the offset.
    public var noOffsetDisappearAnimation: Bool = false
}

// MARK: - Stagger Transition

@available(iOS 18.0, *)
private struct StaggerTransition: Transition {

    var index: Int

    var behavior: StaggerBehavior

    func body(content: Content, phase: TransitionPhase) -> some View {
        let animationDelay = min(Double(index) * behavior.delay, behavior.maxDelay)

        let isIdentity = phase == .identity
        let didDisappear = phase == .didDisappear

        let x = behavior.offset.width
        let reverseX = behavior.disappearInSameDirection ? x : -x
        let disappearCheckX = behavior.noOffsetDisappearAnimation ? 0 : reverseX

        let y = behavior.offset.height
        let reverseY = behavior.disappearInSameDirection ? y : -y
        let disappearCheckY = behavior.noOffsetDisappearAnimation ? 0 : reverseY

        let offsetX = isIdentity ? 0 : didDisappear ? disappearCheckX : x
        let offsetY = isIdentity ? 0 : didDisappear ? disappearCheckY : y

        content
            .opacity(isIdentity ? 1 : 0)
            .blur(radius: isIdentity ? 0 : behavior.blurRadius)
            .compositingGroup()
            .scaleEffect(isIdentity ? 1 : behavior.scale, anchor: behavior.scaleAnchor)
            .offset(x: offsetX, y: offsetY)
            .animation(behavior.animation.delay(animationDelay), value: phase)
    }
}

// MARK: - Preview

@available(iOS 18.0, *)
#Preview("Stagger") {

    @Previewable @State var showStuff: Bool = false

    ScrollView {
        VStack {
            Button("Toggle") {
                showStuff.toggle()
            }
            Stagger(
                StaggerBehavior(
                    delay: 0.05,
                    maxDelay: 1,
                    blurRadius: 6,
                    offset: CGSize(width: 0, height: 100),
                    scale: 0.95,
                    scaleAnchor: .center,
                    animation: .interpolatingSpring,
                    disappearInSameDirection: true,
                    noOffsetDisappearAnimation: false
                )
            ) {

                if showStuff {
                    ForEach(1...10, id: \.self) { _ in

                        HStack(spacing: 10) {
                            Circle()
                                .frame(width: 55, height: 55)

                            VStack(alignment: .leading, spacing: 6) {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(height: 10)
                                    .padding(.trailing, 20)

                                RoundedRectangle(cornerRadius: 5)
                                    .frame(height: 10)
                                    .padding(.trailing, 140)

                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 100, height: 10)
                            }
                        }
                        .foregroundStyle(.gray.opacity(0.7).gradient)

                    }
                }

            }
        }
        .padding(15)
        .frame(maxWidth: .infinity)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
}
