//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorTextValue: View {

    private let string: String
    private let alignment: Alignment

    public init(_ string: String, alignment: Alignment = .leading) {
        self.string = string
        self.alignment = alignment
    }

    public var body: some View {
        Text(.init(string))
            .lineLimit(1)
            .frame(minWidth: 100, maxWidth: .infinity, alignment: alignment)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(.white.opacity(0.1))
            .smoothCornerRadius(4)
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
