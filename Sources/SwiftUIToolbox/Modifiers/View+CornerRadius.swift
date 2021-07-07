//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

#if canImport(UIKit)

import SwiftUI
import UIKit

// MARK: - Rounded Modifier

extension View {

    /// Modifier that applies a clip shape with specified rounded corners.
    ///
    /// - Parameters:
    ///   - radius: The radius of the rounded corners.
    ///   - corners: An option set specifying what corners to apply rounding to.
    /// - Returns: The view with specific rounded corners.
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

// MARK: - Rounded Corners Shape

public struct CornerRadiusShape: Shape {
    
    public let radius: CGFloat
    
    public let corners: UIRectCorner
    
    public init(radius: CGFloat = 0, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        return Path(UIBezierPath(roundedRect: rect,
                                 byRoundingCorners: corners,
                                 cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    }
}

#endif
