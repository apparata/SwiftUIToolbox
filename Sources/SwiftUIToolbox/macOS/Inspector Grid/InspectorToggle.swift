//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct InspectorToggle: View {

    @Binding private var isOn: Bool

    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }

    public var body: some View {
        HStack {
            Toggle(isOn: $isOn) {
                EmptyView()
            }
            .labelsHidden()
            Spacer()
        }
        .padding(.trailing, inspectorGridRowPadding)
    }
}

#endif
