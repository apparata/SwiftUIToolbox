//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

#if canImport(SwiftUI) && canImport(UIKit)

import SwiftUI

/// Wrapper view for `UIVisualEffectView` with blur effect
///
/// Example:
/// ```
/// Blur(isPresented: $showBlur, style: .systemThinMaterial, animated: true)
/// ```
public struct Blur: UIViewRepresentable {

    @Binding var isPresented: Bool
    
    public let style: UIBlurEffect.Style
    
    public let animated: Bool
    
    public init(isPresented: Binding<Bool>, style: UIBlurEffect.Style = .systemThinMaterial, animated: Bool = true) {
        self._isPresented = isPresented
        self.style = style
        self.animated = animated
    }

    public func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        updateUIView(view, context: context)
        return view
    }

    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        if isPresented {
            if uiView.effect == nil {
                if animated {
                    UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                        uiView.effect = context.coordinator.effect
                    }, completion: nil)
                } else {
                    uiView.effect = context.coordinator.effect
                }
            }
        } else {
            if uiView.effect != nil {
                if animated {
                    UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                        uiView.effect = nil
                    }, completion: nil)
                } else {
                    uiView.effect = nil
                }
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    
    public class Coordinator {
    
        var blur: Blur
        
        var effect: UIBlurEffect
        
        init(_ blur: Blur) {
            self.blur = blur
            effect = UIBlurEffect(style: blur.style)
        }
    }
}

#endif
