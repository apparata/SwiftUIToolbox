//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
public typealias NSUIViewRepresentable = NSViewRepresentable
#elseif canImport(UIKit)
import UIKit
public typealias NSUIViewRepresentable = UIViewRepresentable
#endif
