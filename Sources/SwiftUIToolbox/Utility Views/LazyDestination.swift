//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

struct LazyDestination<Destination>: View where Destination: View {
    
    let build: () -> Destination
    
    init(_ build: @autoclosure @escaping () -> Destination) {
        self.build = build
    }

    init(_ build: @escaping () -> Destination) {
        self.build = build
    }
    
    var body: Destination {
        build()
    }
}
