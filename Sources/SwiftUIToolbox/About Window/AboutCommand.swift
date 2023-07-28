//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

public struct AboutCommand: Commands {

    @Environment(\.openWindow) private var openWindow
    
    public var body: some Commands {
        // Replace the About window menu option.
        CommandGroup(replacing: .appInfo) {
            Button {
                openWindow(id: AboutWindow.windowID)
            } label: {
                Text("About \(Bundle.main.name)")
            }
        }
    }
}

#endif
