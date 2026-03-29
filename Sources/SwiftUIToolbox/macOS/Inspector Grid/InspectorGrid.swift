//
//  Copyright © 2024 Apparata AB. All rights reserved.
//

#if os(macOS)

import SwiftUI

/// The default horizontal padding applied to inspector grid rows.
public let inspectorGridRowPadding = 8.0

/// A scrollable grid container for building inspector-style property panels.
///
/// `InspectorGrid` wraps its content in a vertically scrolling `Grid` with
/// consistent spacing. Use it together with the Inspector component views
/// (`InspectorLabel`, `InspectorTextValue`, `InspectorTextField`, etc.) to
/// build sidebar inspectors for editing object properties.
///
/// Each row is typically a `GridRow` containing an ``InspectorLabel`` in the
/// left column and a value view in the right column. Use
/// ``InspectorSectionHeader`` and ``InspectorDivider`` to organize rows
/// into sections.
///
/// ## Example: Basic Inspector
///
/// ```swift
/// InspectorGrid {
///     InspectorSectionHeader("General")
///
///     GridRow {
///         InspectorLabel("Name")
///         InspectorTextField($name)
///     }
///
///     GridRow {
///         InspectorLabel("Type")
///         InspectorTextValue("Document")
///     }
///
///     InspectorDivider()
///
///     InspectorSectionHeader("Stats")
///
///     GridRow {
///         InspectorLabel("Word Count")
///         InspectorNumericField(4200)
///     }
/// }
/// ```
///
/// ## Example: Custom Row Views
///
/// For reuse, define small row views that combine an `InspectorLabel` with a
/// value view inside a `GridRow`:
///
/// ```swift
/// struct InfoRow: View {
///     private let title: String
///     private let details: String
///
///     init(_ title: String, _ details: String) {
///         self.title = title
///         self.details = details
///     }
///
///     var body: some View {
///         GridRow {
///             InspectorLabel(title)
///             InspectorTextValue(details)
///         }
///     }
/// }
/// ```
///
/// Then use them directly inside the grid:
///
/// ```swift
/// InspectorGrid {
///     InspectorSectionHeader("Node")
///     InfoRow("Type", "Transform")
///     InfoRow("Category", "Geometry")
/// }
/// ```
public struct InspectorGrid<Content: View>: View {

    @ViewBuilder let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView(.vertical) {
            Grid(horizontalSpacing: 8, verticalSpacing: 16, content: content)
        }
        .scrollBounceBehavior(.always)
    }
}

#endif
