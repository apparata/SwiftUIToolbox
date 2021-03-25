//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

public struct ScaledOnTapButtonStyle: ButtonStyle {
        
    private let scale: CGFloat
    
    public init(scale: CGFloat) {
        self.scale = scale
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.easeInOut(duration: 0.05))
    }
}
