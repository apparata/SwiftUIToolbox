//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

/// The primary button has a back plate with rounded corners.
public struct PrimaryButton<Label>: View where Label: View {
    
    private let action: () -> Void
    private let label: () -> Label
    private let cornerRadius: CGFloat
    private let textColor: Color
    private let plateColor: Color
    
    public init(cornerRadius: CGFloat = primaryButtonDefaultRadius,
                textColor: Color = .primary,
                plateColor: Color = .accentColor,
                action: @escaping () -> Void,
                @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.plateColor = plateColor
    }
        
    public var body: some View {
        Button(action: action, label: label)
            .buttonStyle(PrimaryButtonStyle(cornerRadius: cornerRadius,
                                            textColor: textColor,
                                            plateColor: plateColor))
    }
}

public extension PrimaryButton where Label == Text {
    
    init(_ title: String,
         cornerRadius: CGFloat = primaryButtonDefaultRadius,
         textColor: Color = .primary,
         plateColor: Color = .accentColor,
         action: @escaping () -> Void) {
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.plateColor = plateColor
        self.action = action
        label = {
            Text(title)
        }
    }
}
