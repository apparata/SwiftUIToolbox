//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorNumericField: View {

    private let string: String

    public init(_ value: Int) {
        string = String(value)
    }

    public init(_ string: String) {
        self.string = string
    }

    public var body: some View {
        Text(.init("`\(string)`"))
            .frame(minWidth: 100, maxWidth: .infinity, alignment: .trailing)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(.white.opacity(0.1))
            .cornerRadius(4)
            .padding(.trailing, inspectorGridRowPadding)
            .contextMenu {
                Button {
                    copyToPasteboard(string)
                } label: {
                    Label("Copy", systemImage: "doc.on.clipboard")
                }
            }
    }
}

#endif
