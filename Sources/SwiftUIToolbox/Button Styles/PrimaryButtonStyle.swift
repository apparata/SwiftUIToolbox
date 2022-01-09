//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

public let primaryButtonDefaultRadius: CGFloat = 6

extension ButtonStyle where Self == PrimaryButtonStyle {
    public static func primary(
        cornerRadius: CGFloat = primaryButtonDefaultRadius,
        textColor: Color = .primary,
        plateColor: Color = .accentColor) -> PrimaryButtonStyle {
            return PrimaryButtonStyle(cornerRadius: cornerRadius,
                                      textColor: textColor,
                                      plateColor: plateColor)
        }
}

/// The primary button style has a back plate with rounded corners.
public struct PrimaryButtonStyle: ButtonStyle {
    
    public let cornerRadius: CGFloat
    
    public let textColor: Color
    
    public let plateColor: Color
    
    public init(cornerRadius: CGFloat = primaryButtonDefaultRadius,
                textColor: Color = .primary,
                plateColor: Color = .accentColor) {
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.plateColor = plateColor
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let isPressed = configuration.isPressed
        return HStack(spacing: 6) {
            configuration.label
        }
        .font(.body)
        .foregroundColor(isPressed ? textColor.opacity(0.4) : textColor)
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
        .background(isPressed ? plateColor.opacity(0.4) : plateColor)
        .cornerRadius(cornerRadius)
    }
}
