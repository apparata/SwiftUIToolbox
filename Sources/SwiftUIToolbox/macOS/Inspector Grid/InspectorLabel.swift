//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorLabel: View {

    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding(.leading, inspectorGridRowPadding)
            .gridColumnAlignment(.trailing)
    }
}

#endif
