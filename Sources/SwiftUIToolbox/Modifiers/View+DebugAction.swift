//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

extension View {
    
    func debugAction(_ action: () -> Void) -> Self {
        #if DEBUG
        action()
        #endif

        return self
    }
}
