//
//  
//

import SwiftUI

public let whatsNewButtonDefaultRadius: CGFloat = 12

/// The What's New button style has a back plate with rounded corners.
public struct WhatsNewButtonStyle: ButtonStyle {
    
    public let cornerRadius: CGFloat
    
    public let textColor: Color
    
    public let plateColor: Color
    
    public let horizontalInset: CGFloat
    
    public let verticalInset: CGFloat
    
    public init(cornerRadius: CGFloat = whatsNewButtonDefaultRadius,
                textColor: Color = .white,
                plateColor: Color = .accentColor,
                horizontalInset: CGFloat = 4,
                verticalInset: CGFloat = 16) {
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.plateColor = plateColor
        self.horizontalInset = horizontalInset
        self.verticalInset = verticalInset
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let isPressed = configuration.isPressed
        return HStack(spacing: 6) {
            configuration.label
        }
        .font(.body)
        .foregroundColor(isPressed ? textColor.opacity(0.4) : textColor)
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: verticalInset,
                            leading: horizontalInset,
                            bottom: verticalInset,
                            trailing: horizontalInset))
        .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .foregroundColor(isPressed ? plateColor.opacity(0.4)
                                                   : plateColor))
    }
}
