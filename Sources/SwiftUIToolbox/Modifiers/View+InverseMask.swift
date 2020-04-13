//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

extension View {
    func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
        self.mask(mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha())
  }
}
