//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

#if canImport(AppKit)

import Foundation
import AppKit

public extension NSWindow {
    
    var alwaysOnTop: Bool {
        get {
            return level.rawValue >= Int(CGWindowLevelForKey(CGWindowLevelKey.statusWindow))
        }
        set {
            if newValue {
                makeKeyAndOrderFront(nil)
                level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(CGWindowLevelKey.statusWindow)))
            } else {
                level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(CGWindowLevelKey.normalWindow)))
            }
        }
    }
}

#endif
