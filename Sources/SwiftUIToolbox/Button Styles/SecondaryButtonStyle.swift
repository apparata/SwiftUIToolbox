//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

public let secondaryButtonDefaultRadius: CGFloat = 6

#if os(macOS)
public let secondaryButtonDefaultPlateColor: Color = .gray
#else
public let secondaryButtonDefaultPlateColor: Color = .systemGray5
#endif

extension ButtonStyle where Self == SecondaryButtonStyle {
    public static func secondary(
        cornerRadius: CGFloat = secondaryButtonDefaultRadius,
        textColor: Color = .primary,
        plateColor: Color = .accentColor) -> SecondaryButtonStyle {
            return SecondaryButtonStyle(cornerRadius: cornerRadius,
                                        textColor: textColor,
                                        plateColor: plateColor)
        }
}

/// The secondary button style has a light back plate with rounded corners.
public struct SecondaryButtonStyle: ButtonStyle {
    
    public let cornerRadius: CGFloat
    
    public let textColor: Color
    
    public let plateColor: Color
    
    public init(cornerRadius: CGFloat = secondaryButtonDefaultRadius,
                textColor: Color = .accentColor,
                plateColor: Color = secondaryButtonDefaultPlateColor) {
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.plateColor = plateColor
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let isPressed = configuration.isPressed
        return HStack(spacing: 4) {
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
