//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

public struct LazyDestination<Destination>: View where Destination: View {
    
    let build: () -> Destination
    
    public init(_ build: @autoclosure @escaping () -> Destination) {
        self.build = build
    }

    public init(_ build: @escaping () -> Destination) {
        self.build = build
    }
    
    public var body: Destination {
        build()
    }
}
