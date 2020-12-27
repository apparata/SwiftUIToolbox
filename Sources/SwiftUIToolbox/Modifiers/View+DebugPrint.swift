//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// Prints a value and returns the unmodified view.
    func debugPrint(_ value: Any) -> some View {
        #if DEBUG
        print(value)
        #endif
        return self
    }
}
