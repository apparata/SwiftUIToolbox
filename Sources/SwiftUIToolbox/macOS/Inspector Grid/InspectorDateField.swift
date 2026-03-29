//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorDateField: View {

    private let date: Date

    private let string: String

    public init(_ date: Date) {
        self.date = date
        self.string = date.formatted(.iso8601)
    }

    public var body: some View {
        Text(.init(string))
            .frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
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
