//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorLinkField: View {

    private let string: String
    private let url: URL?

    public init(_ string: String, url: URL?) {
        self.string = string
        self.url = url
    }

    public var body: some View {
        if let url {
            Link(destination: url) {
                InspectorTextValue(string)
            }
        } else {
            InspectorTextValue(string)
        }
    }
}

#endif
