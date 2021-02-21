//
//  
//

import SwiftUI
#if canImport(AppKit)
import AppKit

extension Color {
    
    public static let systemRed = Color(NSColor.systemRed)
    public static let systemGreen = Color(NSColor.systemGreen)
    public static let systemBlue = Color(NSColor.systemBlue)
    public static let systemOrange = Color(NSColor.systemOrange)
    public static let systemYellow = Color(NSColor.systemYellow)
    public static let systemPink = Color(NSColor.systemPink)
    public static let systemPurple = Color(NSColor.systemPurple)
    public static let systemTeal = Color(NSColor.systemTeal)
    public static let systemIndigo = Color(NSColor.systemIndigo)
    
    public static let systemGray = Color(NSColor.systemGray)
    
    public static let label = Color(NSColor.labelColor)
    public static let secondaryLabel = Color(NSColor.secondaryLabelColor)
    public static let tertiaryLabel = Color(NSColor.tertiaryLabelColor)
    public static let quaternaryLabel = Color(NSColor.quaternaryLabelColor)
    public static let link = Color(NSColor.linkColor)
    public static let placeholderText = Color(NSColor.placeholderTextColor)
    
    public static let separator = Color(NSColor.separatorColor)
    
    public static let systemBackground = Color(NSColor.controlBackgroundColor)
}

#elseif canImport(UIKit)
import UIKit

extension Color {

    public static let systemRed = Color(UIColor.systemRed)
    public static let systemGreen = Color(UIColor.systemGreen)
    public static let systemBlue = Color(UIColor.systemBlue)
    public static let systemOrange = Color(UIColor.systemOrange)
    public static let systemYellow = Color(UIColor.systemYellow)
    public static let systemPink = Color(UIColor.systemPink)
    public static let systemPurple = Color(UIColor.systemPurple)
    public static let systemTeal = Color(UIColor.systemTeal)
    public static let systemIndigo = Color(UIColor.systemIndigo)
    
    public static let systemGray = Color(UIColor.systemGray)
    public static let systemGray2 = Color(UIColor.systemGray2)
    public static let systemGray3 = Color(UIColor.systemGray3)
    public static let systemGray4 = Color(UIColor.systemGray4)
    public static let systemGray5 = Color(UIColor.systemGray5)
    public static let systemGray6 = Color(UIColor.systemGray6)
    
    public static let label = Color(UIColor.label)
    public static let secondaryLabel = Color(UIColor.secondaryLabel)
    public static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    public static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    public static let link = Color(UIColor.link)
    public static let placeholderText = Color(UIColor.placeholderText)
    
    public static let separator = Color(UIColor.separator)
    public static let opaqueSeparator = Color(UIColor.opaqueSeparator)
    
    public static let systemBackground = Color(UIColor.systemBackground)
    public static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    public static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    public static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    public static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    public static let tertiarySystemGroupedBackground = Color(UIColor.tertiarySystemGroupedBackground)
    
    public static let systemFill = Color(UIColor.systemFill)
    public static let secondarySystemFill = Color(UIColor.secondarySystemFill)
    public static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
    public static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
}
#endif
