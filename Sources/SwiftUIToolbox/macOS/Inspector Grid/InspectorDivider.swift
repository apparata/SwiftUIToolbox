//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorDivider: View {

    public init() {}

    public var body: some View {
        Divider()
            .padding(.horizontal, inspectorGridRowPadding)
    }
}

#endif
