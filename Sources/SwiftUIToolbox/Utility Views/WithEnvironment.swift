//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - WithEnvironment

/// View that passes in the environment values to its content view builder.
///
/// **Example:**
///
/// ```
/// struct ExampleView: View {
///     var body: some View {
///         WithEnvironment { environment in
///             Text(environment.colorScheme == .light ? "Light": "Dark")
///         }
///     }
/// }
/// ```
struct WithEnvironment<Content: View>: View {
    
    @Environment(\.self) private var environment
    
    private let content: (EnvironmentValues) -> Content
    
    init(@ViewBuilder content: @escaping (EnvironmentValues) -> Content) {
        self.content = content
    }
    
    var body: some View {
        content(environment)
    }
}
