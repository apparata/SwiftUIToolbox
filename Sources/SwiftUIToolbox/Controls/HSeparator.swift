//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

/// A 1 pixel horizontal separator view.
public struct HSeparator: View {
    
    @Environment(\.displayScale) private var displayScale
    
    public let color: Color
    
    public init(color: Color = .separator) {
        self.color = color
    }
    
    public var body: some View {
        color
            .frame(height: (1 / displayScale))
            .frame(maxWidth: .infinity)
    }
}

struct HSeparator_Previews: PreviewProvider {
    static var previews: some View {
        HSeparator()
            .frame(width: 150, height: 100)
            .previewLayout(.sizeThatFits)
    }
}
