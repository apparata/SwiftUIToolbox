//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
public typealias NSUIImage = NSImage
#elseif canImport(UIKit)
import UIKit
public typealias NSUIImage = UIImage
#endif

extension Image {
    
    init(nsuiImage: NSUIImage) {
        #if canImport(AppKit)
        self.init(nsImage: nsuiImage)
        #elseif canImport(UIKit)
        self.init(uiImage: nsuiImage)
        #endif
    }
}
