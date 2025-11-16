//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

#if canImport(AppKit)
import AppKit

public extension NSImage {
    
    convenience init(requiredNamed name: String) {
        // swiftlint:disable:next force_unwrapping
        self.init(named: name)!
    }
}
#endif
