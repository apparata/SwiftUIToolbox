//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

extension ButtonStyle where Self == ScaledOnTapButtonStyle {
    public static func scaledOnTap(scale: CGFloat) -> ScaledOnTapButtonStyle {
            return ScaledOnTapButtonStyle(scale: scale)
        }
}

public struct ScaledOnTapButtonStyle: ButtonStyle {
        
    private let scale: CGFloat
    
    public init(scale: CGFloat) {
        self.scale = scale
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.easeInOut(duration: 0.05), value: configuration.isPressed)
    }
}
