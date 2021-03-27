//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

/// A black view with 30% opacity (by default) that dims views behind it.
public struct DimView: View {
    
    public let opacity: Double
    
    public init(opacity: Double = 0.3) {
        self.opacity = opacity
    }
    
    public var body: some View {
        Color.black
            .opacity(opacity)
    }
}

struct DimView_Previews: PreviewProvider {
    static var previews: some View {
        DimView()
            .frame(width: 150, height: 100)
            .previewLayout(.sizeThatFits)
    }
}
