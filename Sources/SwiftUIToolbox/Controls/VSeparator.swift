//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

/// A 1 pixel vertical separator view.
public struct VSeparator: View {
    
    @Environment(\.displayScale) private var displayScale
    
    public let color: Color

    public init(color: Color = .separator) {
        self.color = color
    }
    
    public var body: some View {
        color
            .frame(width: (1 / displayScale))
            .frame(maxHeight: .infinity)
    }
}
