//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

/// Triangle shape that points upwards.
public struct Triangle: Shape {
    
    public init() {
        //
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}
