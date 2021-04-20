//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

private let yAxis: (CGFloat, CGFloat, CGFloat) = (0, 1, 0)

public struct FlipView<Front: View, Back: View>: View {

    var isFlipped: Bool
    var front: () -> Front
    var back: () -> Back
    
    public init(isFlipped: Bool, @ViewBuilder front: @escaping() -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.isFlipped = isFlipped
        self.front = front
        self.back = back
    }

    public var body: some View {
        ZStack {
            front()
                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: yAxis)
                .opacity(isFlipped ? 0 : 1)
                .accessibility(hidden: isFlipped)
            
            back()
                .rotation3DEffect(.degrees(isFlipped ? 0 : -180), axis: yAxis)
                .opacity(isFlipped ? 1 : -1)
                .accessibility(hidden: !isFlipped)
        }
    }
}
