//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

#if canImport(AppKit)
import AppKit
public typealias NSUIColor = NSColor
#elseif canImport(UIKit)
import UIKit
public typealias NSUIColor = UIColor
#endif
