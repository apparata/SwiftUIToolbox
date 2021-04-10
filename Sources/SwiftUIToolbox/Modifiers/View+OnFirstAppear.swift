//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

extension View {

    /// If you have a view that lives in a `NavigationView`, its `onAppear(...)` closure
    /// will get called when you navigate back and forth. The `onFirstAppear` modifier wraps
    /// `onAppear` and uses a `@State` to make sure the closure is only called the first time.
    public func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(OnFirstAppear(perform: perform))
    }
}

private struct OnFirstAppear: ViewModifier {
    
    let perform: () -> Void
    
    @State private var firstAppearance = true
    
    func body(content: Content) -> some View {
        content.onAppear {
            if firstAppearance {
                firstAppearance = false
                perform()
            }
        }
    }
}
