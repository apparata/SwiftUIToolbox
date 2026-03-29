//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorSectionHeader: View {

    private let title: String

    public init(_ title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 16)
            .padding(.top, 4)
            .padding(.leading, inspectorGridRowPadding)
            .gridCellUnsizedAxes(.horizontal)
    }
}

#endif
