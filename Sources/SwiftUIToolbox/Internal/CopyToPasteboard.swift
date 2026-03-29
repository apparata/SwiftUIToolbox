//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import AppKit

func copyToPasteboard(_ string: String) {
    NSPasteboard.general.clearContents()
    NSPasteboard.general.setString(string, forType: .string)
}

#endif
