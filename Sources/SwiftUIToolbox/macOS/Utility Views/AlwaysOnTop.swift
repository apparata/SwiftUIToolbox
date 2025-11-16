//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

// MARK: - Always on Top

/// Set this view as a background on e.g. the main view.
public struct AlwaysOnTop: View {

    static let settingsKey = "window.setting.isAlwaysOnTop"

    @AppStorage(Self.settingsKey) private var isAlwaysOnTop: Bool = false

    @State private var window: NSWindow?

    public var body: some View {
        WindowReflection(window: $window)
            .onReceive(window.publisher) { window in
                window.alwaysOnTop = isAlwaysOnTop
            }
            .onChange(of: isAlwaysOnTop) { _, isOnTop in
                window?.alwaysOnTop = isOnTop
            }
    }
}

// MARK: - Always on Top Command

public struct AlwaysOnTopCommand: Commands {

    public var body: some Commands {
        CommandGroup(after: .windowArrangement) {
            // There is a SwiftUI bug that keeps the checkmark from updating.
            AlwaysOnTopCheckbox("Toggle Always on Top")
        }
    }
}

// MARK: - Always on Top Checkbox

struct AlwaysOnTopCheckbox: View {
    
    let title: LocalizedStringKey
    
    @AppStorage(AlwaysOnTop.settingsKey) var isAlwaysOnTop: Bool = false
    
    init(_ title: LocalizedStringKey = "Always on top") {
        self.title = title
    }
    
    var body: some View {
        Toggle(title, isOn: $isAlwaysOnTop)
            .toggleStyle(CheckboxToggleStyle())
    }
}

// MARK: - Preview

#Preview {
    AlwaysOnTopCheckbox()
}

#endif

