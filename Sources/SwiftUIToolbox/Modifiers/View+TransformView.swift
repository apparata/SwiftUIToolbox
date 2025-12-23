//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import SwiftUI

public extension View {
    /// Transform a view, for example with conditional changes, without inherently breaking the view identity.
    func transformView(@ViewBuilder content: (_ view: Self) -> some View) -> some View {
        content(self)
    }
}

#Preview {
    Button("Hello, World!") {}
        .transformView { view in
            // EXAMPLE:
            //if #available(iOS 26.0 *) {
            //    view.buttonStyle(.glass)
            //} else {
                view.buttonStyle(.bordered)
            //}
        }
}
